//
//  StreamChatAI.swift
//  AIPlayground
//
//  Created by Martin Mitrevski on 1.10.24.
//

import Foundation
import StreamChat

public class StreamChatAI {
    private let apiKey: String
    private let assistantsAPI: AssistantsAPI
    
    private var assistantObject: AssistantObject?
    private var threadObject: ThreadObject?
    private var runId: String?
    
    public init(apiKey: String) {
        self.apiKey = apiKey
        let basePath = "https://api.openai.com/v1"
        let transport = URLSessionTransport()
        let middleware = APIKeyMiddleware(apiKey: apiKey)
        let decoder = JSONDecoder()
        self.assistantsAPI = AssistantsAPI(
            basePath: basePath,
            transport: transport,
            streamingTransport: URLSessionStreamingTransport(apiKey: apiKey),
            middlewares: [middleware],
            jsonDecoder: decoder
        )
    }
    
    public func createAssistant(name: String, model: String) async throws {
        self.assistantObject = try await assistantsAPI.createAssistant(
            createAssistantRequest: .init(
                model: model,
                name: name
            )
        )
    }
    
    public func createThread(with messages: [CreateMessageRequest]) async throws {
        let threadRequest = CreateThreadRequest(messages: messages, toolResources: nil, metadata: nil)
        self.threadObject = try await assistantsAPI.createThread(createThreadRequest: threadRequest)
    }
    
    public func createRun(
        content: String,
        additionalMessages: [CreateMessageRequest] = [],
        stream: Bool
    ) async throws -> AsyncStream<StreamingChunk> {
        guard let assistantObject else {
            throw ClientError.assistantNotCreated
        }
        
        guard let threadObject else {
            throw ClientError.threadNotCreated
        }
        
        let createRunRequest = CreateRunRequest(
            assistantId: assistantObject.id,
            additionalMessages: [CreateMessageRequest(role: .user, content: .typeString(content))],
            stream: stream
        )
        
        return AsyncStream { continuation in
            do {
                try assistantsAPI.createRun(
                    threadId: threadObject.id,
                    createRunRequest: createRunRequest
                ) { chunk in
                    continuation.yield(chunk)
                } onFinish: {
                    continuation.finish()
                }
            } catch {
                continuation.finish()
            }
        }
    }
    
    public func getRun(threadId: String, runId: String) async throws -> AsyncStream<StreamingChunk> {
        AsyncStream { continuation in
            do {
                try assistantsAPI.getRun(threadId: runId, runId: runId) { chunk in
                    continuation.yield(chunk)
                } onFinish: {
                    continuation.finish()
                }
            } catch {
                continuation.finish()
            }
        }
    }
    
    public func cancelRun(runId: String) async throws {
        guard let threadId = threadObject?.id else {
            throw ClientError.threadNotCreated
        }
        
        _ = try await assistantsAPI.cancelRun(threadId: threadId, runId: runId)
    }
    
    public func createMessage(
        createMessageRequest: CreateMessageRequest
    ) async throws -> MessageObject {
        guard let threadObject else { throw ClientError.threadNotCreated }
        return try await assistantsAPI.createMessage(
            threadId: threadObject.id,
            createMessageRequest: createMessageRequest
        )
    }
}

extension ClientError {
    public static let assistantNotCreated = ClientError("Assistant not created")
    public static let threadNotCreated = ClientError("Thread not created")
}
