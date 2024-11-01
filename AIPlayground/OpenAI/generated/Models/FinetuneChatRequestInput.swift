//
// FinetuneChatRequestInput.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
/** The per-line training example of a fine-tuning input file for chat models */

public struct FinetuneChatRequestInput: Codable, JSONEncodable, Hashable {
    public var messages: [FinetuneChatRequestInputMessagesInner]?
    /** A list of tools the model may generate JSON inputs for. */
    public var tools: [ChatCompletionTool]?
    /** Whether to enable [parallel function calling](/docs/guides/function-calling/parallel-function-calling) during tool use. */
    public var parallelToolCalls: Bool? = true
    /** A list of functions the model may generate JSON inputs for. */
    @available(*, deprecated, message: "This property is deprecated.")
    public var functions: [ChatCompletionFunctions]?

    public init(messages: [FinetuneChatRequestInputMessagesInner]? = nil, tools: [ChatCompletionTool]? = nil, parallelToolCalls: Bool? = true, functions: [ChatCompletionFunctions]? = nil) {
        self.messages = messages
        self.tools = tools
        self.parallelToolCalls = parallelToolCalls
        self.functions = functions
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case messages
        case tools
        case parallelToolCalls = "parallel_tool_calls"
        case functions
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(messages, forKey: .messages)
        try container.encodeIfPresent(tools, forKey: .tools)
        try container.encodeIfPresent(parallelToolCalls, forKey: .parallelToolCalls)
        try container.encodeIfPresent(functions, forKey: .functions)
    }
}

