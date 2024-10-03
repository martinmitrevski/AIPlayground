//
//  OpenAIService.swift
//  AIPlayground
//
//  Created by Martin Mitrevski on 1.10.24.
//

import Foundation

class OpenAIService: NSObject, URLSessionDataDelegate {
    private let apiKey: String
    private var session: URLSession!
    private var completion: ((String) -> Void)?
    private var onFinish: (() -> Void)?
    
    init(apiKey: String) {
        self.apiKey = apiKey
        super.init()
        
        let configuration = URLSessionConfiguration.default
        self.session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }
    
    func sendMessageStreaming(messages: [[String: String]], completion: @escaping (String) -> Void, onFinish: @escaping () -> Void) {
        var request = URLRequest(url: URL(string: "https://api.openai.com/v1/chat/completions")!)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "model": "gpt-4",
            "messages": messages,
            "stream": true
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        self.completion = completion
        self.onFinish = onFinish
        
        // Start the streaming request
        let task = session.dataTask(with: request)
        task.resume()
    }
    
    // This delegate method is called whenever data is received
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
        
        // Call the onFinish handler
        self.onFinish?()
    }
    
    private func parseStreamingResponse(_ text: String) {
        // OpenAI streams responses as individual chunks, separated by `\n\n`.
        let lines = text.components(separatedBy: "\n")
        for line in lines {
            if line.starts(with: "data: ") {
                let jsonString = line.replacingOccurrences(of: "data: ", with: "")
                
                if let jsonData = jsonString.data(using: .utf8),
                   let jsonObject = try? JSONSerialization.jsonObject(with: jsonData) as? [String: Any],
                   let choices = jsonObject["choices"] as? [[String: Any]],
                   let delta = choices.first?["delta"] as? [String: Any],
                   let content = delta["content"] as? String {
                    // Send the content back to the completion handler in chunks.
                    self.completion?(content)
                }
            }
        }
    }
}
