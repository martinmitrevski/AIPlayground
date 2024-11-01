//
// CreateCompletionRequestPrompt.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
/** The prompt(s) to generate completions for, encoded as a string, array of strings, array of tokens, or array of token arrays.  Note that &lt;|endoftext|&gt; is the document separator that the model sees during training, so if a prompt is not specified the model will generate as if from the beginning of a new document.  */


public enum CreateCompletionRequestPrompt: Codable, JSONEncodable, Hashable {
    case typeString(String)
    case typeIntArray([Int])
    case typeStringArray([String])
    case typeIntArray2D([[Int]])
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .typeString(let value):
            try container.encode(value)
        case .typeIntArray(let value):
            try container.encode(value)
        case .typeStringArray(let value):
            try container.encode(value)
        case .typeIntArray2D(let value):
            try container.encode(value)
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
                if let value = try? container.decode(String.self) {
            self = .typeString(value)
                } else if let value = try? container.decode([Int].self) {
            self = .typeIntArray(value)
                } else if let value = try? container.decode([String].self) {
            self = .typeStringArray(value)
                } else if let value = try? container.decode([[Int]].self) {
            self = .typeIntArray2D(value)
        } else {
            throw DecodingError.typeMismatch(Self.Type.self, .init(codingPath: decoder.codingPath, debugDescription: "Unable to decode instance of CreateCompletionRequestPrompt"))
        }
    }
}
