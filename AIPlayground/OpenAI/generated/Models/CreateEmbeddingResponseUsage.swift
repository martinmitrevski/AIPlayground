//
// CreateEmbeddingResponseUsage.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
/** The usage information for the request. */

public struct CreateEmbeddingResponseUsage: Codable, JSONEncodable, Hashable {
    /** The number of tokens used by the prompt. */
    public var promptTokens: Int
    /** The total number of tokens used by the request. */
    public var totalTokens: Int

    public init(promptTokens: Int, totalTokens: Int) {
        self.promptTokens = promptTokens
        self.totalTokens = totalTokens
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case promptTokens = "prompt_tokens"
        case totalTokens = "total_tokens"
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(promptTokens, forKey: .promptTokens)
        try container.encode(totalTokens, forKey: .totalTokens)
    }
}

