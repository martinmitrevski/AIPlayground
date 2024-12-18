//
// RunObjectRequiredAction.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
/** Details on the action required to continue the run. Will be &#x60;null&#x60; if no action is required. */

public struct RunObjectRequiredAction: Codable, JSONEncodable, Hashable {
    public enum ModelType: String, Codable, CaseIterable {
        case submitToolOutputs = "submit_tool_outputs"
    }
    /** For now, this is always `submit_tool_outputs`. */
    public var type: ModelType
    public var submitToolOutputs: RunObjectRequiredActionSubmitToolOutputs

    public init(type: ModelType, submitToolOutputs: RunObjectRequiredActionSubmitToolOutputs) {
        self.type = type
        self.submitToolOutputs = submitToolOutputs
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case type
        case submitToolOutputs = "submit_tool_outputs"
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(submitToolOutputs, forKey: .submitToolOutputs)
    }
}

