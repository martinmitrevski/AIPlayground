//
// ChatCompletionRequestMessage.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation



public enum ChatCompletionRequestMessage: Codable, JSONEncodable, Hashable {
    case typeChatCompletionRequestAssistantMessage(ChatCompletionRequestAssistantMessage)
    case typeChatCompletionRequestFunctionMessage(ChatCompletionRequestFunctionMessage)
    case typeChatCompletionRequestSystemMessage(ChatCompletionRequestSystemMessage)
    case typeChatCompletionRequestToolMessage(ChatCompletionRequestToolMessage)
    case typeChatCompletionRequestUserMessage(ChatCompletionRequestUserMessage)
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .typeChatCompletionRequestAssistantMessage(let value):
            try container.encode(value)
        case .typeChatCompletionRequestFunctionMessage(let value):
            try container.encode(value)
        case .typeChatCompletionRequestSystemMessage(let value):
            try container.encode(value)
        case .typeChatCompletionRequestToolMessage(let value):
            try container.encode(value)
        case .typeChatCompletionRequestUserMessage(let value):
            try container.encode(value)
        }
    }


    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
                if let value = try? container.decode(ChatCompletionRequestAssistantMessage.self) {
            self = .typeChatCompletionRequestAssistantMessage(value)
                } else if let value = try? container.decode(ChatCompletionRequestFunctionMessage.self) {
            self = .typeChatCompletionRequestFunctionMessage(value)
                } else if let value = try? container.decode(ChatCompletionRequestSystemMessage.self) {
            self = .typeChatCompletionRequestSystemMessage(value)
                } else if let value = try? container.decode(ChatCompletionRequestToolMessage.self) {
            self = .typeChatCompletionRequestToolMessage(value)
                } else if let value = try? container.decode(ChatCompletionRequestUserMessage.self) {
            self = .typeChatCompletionRequestUserMessage(value)
        } else {
            throw DecodingError.typeMismatch(Self.Type.self, .init(codingPath: decoder.codingPath, debugDescription: "Unable to decode instance of ChatCompletionRequestMessage"))
        }
    }
}

