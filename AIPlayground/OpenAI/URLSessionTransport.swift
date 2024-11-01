//
//  URLSessionTransport.swift
//  AIPlayground
//
//  Created by Martin Mitrevski on 9.10.24.
//

import Foundation

final class URLSessionTransport: NSObject, AssistantsAPITransport, FilesAPITransport, @unchecked Sendable {
    private var urlSession: URLSession!
    private let updateQueue: DispatchQueue = .init(
        label: "com.mitrevski.URLSessionClient",
        qos: .userInitiated
    )

    override init() {
        super.init()
        self.urlSession = URLSession.shared
    }

    func execute(request: URLRequest) async throws -> (Data, URLResponse) {
        return try await execute(request: request, isRetry: false)
    }
    
    var continuation: CheckedContinuation<(Data, URLResponse), any Error>?

    private func execute(request: URLRequest, isRetry: Bool) async throws -> (Data, URLResponse) {
        try await withCheckedThrowingContinuation { continuation in
            let task = urlSession.dataTask(with: request) { data, response, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                if let response = response as? HTTPURLResponse {
                    if response.statusCode >= 400 || data == nil {
                        continuation.resume(throwing: NSError(domain: "com.mitrevski.error", code: 123))
                        return
                    }
                }
                guard let data = data, let response = response else {
                    continuation.resume(
                        throwing: NSError(domain: "com.mitrevski.error", code: 123)
                    )
                    return
                }
                continuation.resume(returning: (data, response))
            }
            task.resume()
        }
    }
    
    func execute(request: Request) async throws -> (Data, URLResponse) {
        var clone = request
        clone.headers["Content-Type"] = "application/json"
        do {
            return try await execute(request: clone.urlRequest())
        } catch {
            // Log error and rethrow
            print(
                "Error: URLSessionTransport: \(String(describing: request.url.absoluteString))\n"
                    + "Headers:\n\(String(describing: request.headers))\n"
                    + "Query items:\n\(request.queryParams)"
            )
            throw error
        }
    }
}

final class URLSessionStreamingTransport: NSObject, StreamingAPITransport, @unchecked Sendable, URLSessionDelegate, URLSessionDataDelegate {
    
    private var urlSession: URLSession!
    private let updateQueue: DispatchQueue = .init(
        label: "com.mitrevski.URLSessionClient",
        qos: .userInitiated
    )
    
    private var onReceive: ((StreamingChunk) -> Void)?
    private var onFinish: (() -> Void)?
    
    let apiKey: String

    init(apiKey: String) {
        self.apiKey = apiKey
        super.init()
        let configuration = URLSessionConfiguration.default
        self.urlSession = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }
    
    func execute(request: Request, onReceive: @escaping (StreamingChunk) -> (), onFinish: @escaping () -> ()) throws {
        self.onReceive = onReceive
        self.onFinish = onFinish

        var modifiedRequest = request
        modifiedRequest.headers["Authorization"] = "Bearer \(apiKey)"
        modifiedRequest.headers["OpenAI-Beta"] = "assistants=v2"
        
        let urlRequest: URLRequest = try! modifiedRequest.urlRequest()

        let task = urlSession.dataTask(with: urlRequest)
        task.resume()
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        if let chunk = String(data: data, encoding: .utf8) {
            // Process the streaming chunks
            parseStreamingResponse(chunk)
        }
    }
    
    // Called when the request completes
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            print("Error during streaming: \(error.localizedDescription)")
        } else {
            print("Streaming completed")
        }
        self.onFinish?()
    }
    
    private func parseStreamingResponse(_ text: String) {
        // OpenAI streams responses as individual chunks, separated by `\n\n`.
        let lines = text.components(separatedBy: "\n")
        var eventName = ""
        var textChunk = ""
        var runId = ""
        var threadId = ""
        for line in lines {
            if line.starts(with: "event: ") {
                eventName = line.replacingOccurrences(of: "event: ", with: "")
            } else if line.starts(with: "data: ") {
                let jsonString = line.replacingOccurrences(of: "data: ", with: "")
                
                guard let jsonData = jsonString.data(using: .utf8),
                      let jsonObject = try? JSONSerialization.jsonObject(with: jsonData) as? [String: Any] else {
                    continue
                }
                
                runId = jsonObject["id"] as? String ?? ""
                threadId = jsonObject["thread_id"] as? String ?? ""
                
                if let delta = jsonObject["delta"] as? [String: Any],
                   let content = delta["content"] as? [[String: Any]],
                   let text = content.first?["text"] as? [String: String] {
                    if textChunk.isEmpty {
                        textChunk = text["value"] ?? ""
                    }
                }
            }
        }
        onReceive?(StreamingChunk(runId: runId, threadId: threadId, event: eventName, text: textChunk))
    }
}

public struct StreamingChunk {
    public let runId: String
    public let threadId: String
    public let event: String
    public let text: String?
}

struct APIKeyMiddleware: @unchecked Sendable, AssistantsAPIClientMiddleware, FilesAPIClientMiddleware {
            
    var apiKey: String
    
    func intercept(
        _ request: Request,
        next: (Request) async throws -> (Data, URLResponse)
    ) async throws -> (Data, URLResponse) {
        var modifiedRequest = request
        modifiedRequest.headers["Authorization"] = "Bearer \(apiKey)"
        modifiedRequest.headers["OpenAI-Beta"] = "assistants=v2"
        return try await next(modifiedRequest)
    }
}
