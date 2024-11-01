//
// ChatCompletionRequestAssistantMessageContent.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
/** The contents of the assistant message. Required unless &#x60;tool_calls&#x60; or &#x60;function_call&#x60; is specified.  */


public enum ChatCompletionRequestAssistantMessageContent: Codable, JSONEncodable, Hashable {
    case typeString(String)
    case typeChatCompletionRequestAssistantMessageContentPart([ChatCompletionRequestAssistantMessageContentPart])
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .typeString(let value):
            try container.encode(value)
        case .typeChatCompletionRequestAssistantMessageContentPart(let value):
            try container.encode(value)
        }
    }


    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
                if let value = try? container.decode(String.self) {
            self = .typeString(value)
                } else if let value = try? container.decode([ChatCompletionRequestAssistantMessageContentPart].self) {
            self = .typeChatCompletionRequestAssistantMessageContentPart(value)
        } else {
            throw DecodingError.typeMismatch(Self.Type.self, .init(codingPath: decoder.codingPath, debugDescription: "Unable to decode instance of ChatCompletionRequestAssistantMessageContent"))
        }
    }
}

