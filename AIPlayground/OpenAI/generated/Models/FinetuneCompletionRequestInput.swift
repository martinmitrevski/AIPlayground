//
// FinetuneCompletionRequestInput.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
/** The per-line training example of a fine-tuning input file for completions models */

public struct FinetuneCompletionRequestInput: Codable, JSONEncodable, Hashable {
    /** The input prompt for this training example. */
    public var prompt: String?
    /** The desired completion for this training example. */
    public var completion: String?

    public init(prompt: String? = nil, completion: String? = nil) {
        self.prompt = prompt
        self.completion = completion
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case prompt
        case completion
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(prompt, forKey: .prompt)
        try container.encodeIfPresent(completion, forKey: .completion)
    }
}

