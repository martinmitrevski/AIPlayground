//
//  StreamChatAI.swift
//  AIPlayground
//
//  Created by Martin Mitrevski on 1.10.24.
//

import Foundation

class StreamChatAI {
    private let apiKey: String
    
    private let openAIService: OpenAIService
    
    init(apiKey: String) {
        self.apiKey = apiKey
        openAIService = OpenAIService(apiKey: apiKey)
    }
    
    func sendMessageStreaming(
        messages: [[String: String]],
        completion: @escaping (String) -> Void,
        onFinish: @escaping () -> Void
    ) {        
        openAIService.sendMessageStreaming(
            messages: messages,
            completion: completion,
            onFinish: onFinish
        )
    }
}
