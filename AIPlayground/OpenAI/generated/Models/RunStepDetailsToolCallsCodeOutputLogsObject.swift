//
// RunStepDetailsToolCallsCodeOutputLogsObject.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
/** Text output from the Code Interpreter tool call as part of a run step. */

public struct RunStepDetailsToolCallsCodeOutputLogsObject: Codable, JSONEncodable, Hashable {
    public enum ModelType: String, Codable, CaseIterable {
        case logs = "logs"
    }
    /** Always `logs`. */
    public var type: ModelType
    /** The text output from the Code Interpreter tool call. */
    public var logs: String

    public init(type: ModelType, logs: String) {
        self.type = type
        self.logs = logs
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case type
        case logs
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(logs, forKey: .logs)
    }
}

