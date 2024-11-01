//
// RunStepDeltaStepDetailsToolCallsCodeObject.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
/** Details of the Code Interpreter tool call the run step was involved in. */

public struct RunStepDeltaStepDetailsToolCallsCodeObject: Codable, JSONEncodable, Hashable {
    public enum ModelType: String, Codable, CaseIterable {
        case codeInterpreter = "code_interpreter"
    }
    /** The index of the tool call in the tool calls array. */
    public var index: Int
    /** The ID of the tool call. */
    public var id: String?
    /** The type of tool call. This is always going to be `code_interpreter` for this type of tool call. */
    public var type: ModelType
    public var codeInterpreter: RunStepDeltaStepDetailsToolCallsCodeObjectCodeInterpreter?

    public init(index: Int, id: String? = nil, type: ModelType, codeInterpreter: RunStepDeltaStepDetailsToolCallsCodeObjectCodeInterpreter? = nil) {
        self.index = index
        self.id = id
        self.type = type
        self.codeInterpreter = codeInterpreter
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case index
        case id
        case type
        case codeInterpreter = "code_interpreter"
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(index, forKey: .index)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encode(type, forKey: .type)
        try container.encodeIfPresent(codeInterpreter, forKey: .codeInterpreter)
    }
}

