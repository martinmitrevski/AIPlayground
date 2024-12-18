//
// CreateChatCompletionRequestFunctionCall.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
/** Deprecated in favor of &#x60;tool_choice&#x60;.  Controls which (if any) function is called by the model. &#x60;none&#x60; means the model will not call a function and instead generates a message. &#x60;auto&#x60; means the model can pick between generating a message or calling a function. Specifying a particular function via &#x60;{\&quot;name\&quot;: \&quot;my_function\&quot;}&#x60; forces the model to call that function.  &#x60;none&#x60; is the default when no functions are present. &#x60;auto&#x60; is the default if functions are present.  */
@available(*, deprecated, message: "This schema is deprecated.")


public enum CreateChatCompletionRequestFunctionCall: Codable, JSONEncodable, Hashable {
    case typeChatCompletionFunctionCallOption(ChatCompletionFunctionCallOption)
    case typeString(String)
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .typeChatCompletionFunctionCallOption(let value):
            try container.encode(value)
        case .typeString(let value):
            try container.encode(value)
        }
    }


    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
                if let value = try? container.decode(ChatCompletionFunctionCallOption.self) {
            self = .typeChatCompletionFunctionCallOption(value)
                } else if let value = try? container.decode(String.self) {
            self = .typeString(value)
        } else {
            throw DecodingError.typeMismatch(Self.Type.self, .init(codingPath: decoder.codingPath, debugDescription: "Unable to decode instance of CreateChatCompletionRequestFunctionCall"))
        }
    }
}

