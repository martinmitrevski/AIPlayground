//
// RunToolCallObject.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
/** Tool call objects */

public struct RunToolCallObject: Codable, JSONEncodable, Hashable {
    public enum ModelType: String, Codable, CaseIterable {
        case function = "function"
    }
    /** The ID of the tool call. This ID must be referenced when you submit the tool outputs in using the [Submit tool outputs to run](/docs/api-reference/runs/submitToolOutputs) endpoint. */
    public var id: String
    /** The type of tool call the output is required for. For now, this is always `function`. */
    public var type: ModelType
    public var function: RunToolCallObjectFunction

    public init(id: String, type: ModelType, function: RunToolCallObjectFunction) {
        self.id = id
        self.type = type
        self.function = function
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case type
        case function
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(type, forKey: .type)
        try container.encode(function, forKey: .function)
    }
}
