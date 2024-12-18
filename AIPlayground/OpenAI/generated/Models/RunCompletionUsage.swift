//
// RunCompletionUsage.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
/** Usage statistics related to the run. This value will be &#x60;null&#x60; if the run is not in a terminal state (i.e. &#x60;in_progress&#x60;, &#x60;queued&#x60;, etc.). */

public struct RunCompletionUsage: Codable, JSONEncodable, Hashable {
    /** Number of completion tokens used over the course of the run. */
    public var completionTokens: Int
    /** Number of prompt tokens used over the course of the run. */
    public var promptTokens: Int
    /** Total number of tokens used (prompt + completion). */
    public var totalTokens: Int

    public init(completionTokens: Int, promptTokens: Int, totalTokens: Int) {
        self.completionTokens = completionTokens
        self.promptTokens = promptTokens
        self.totalTokens = totalTokens
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case completionTokens = "completion_tokens"
        case promptTokens = "prompt_tokens"
        case totalTokens = "total_tokens"
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(completionTokens, forKey: .completionTokens)
        try container.encode(promptTokens, forKey: .promptTokens)
        try container.encode(totalTokens, forKey: .totalTokens)
    }
}

