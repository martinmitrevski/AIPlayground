//
// RunStepDeltaStepDetailsToolCallsObjectToolCallsInner.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation



public enum RunStepDeltaStepDetailsToolCallsObjectToolCallsInner: Codable, JSONEncodable, Hashable {
    case typeRunStepDeltaStepDetailsToolCallsCodeObject(RunStepDeltaStepDetailsToolCallsCodeObject)
    case typeRunStepDeltaStepDetailsToolCallsFileSearchObject(RunStepDeltaStepDetailsToolCallsFileSearchObject)
    case typeRunStepDeltaStepDetailsToolCallsFunctionObject(RunStepDeltaStepDetailsToolCallsFunctionObject)
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .typeRunStepDeltaStepDetailsToolCallsCodeObject(let value):
            try container.encode(value)
        case .typeRunStepDeltaStepDetailsToolCallsFileSearchObject(let value):
            try container.encode(value)
        case .typeRunStepDeltaStepDetailsToolCallsFunctionObject(let value):
            try container.encode(value)
        }
    }


    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
                if let value = try? container.decode(RunStepDeltaStepDetailsToolCallsCodeObject.self) {
            self = .typeRunStepDeltaStepDetailsToolCallsCodeObject(value)
                } else if let value = try? container.decode(RunStepDeltaStepDetailsToolCallsFileSearchObject.self) {
            self = .typeRunStepDeltaStepDetailsToolCallsFileSearchObject(value)
                } else if let value = try? container.decode(RunStepDeltaStepDetailsToolCallsFunctionObject.self) {
            self = .typeRunStepDeltaStepDetailsToolCallsFunctionObject(value)
        } else {
            throw DecodingError.typeMismatch(Self.Type.self, .init(codingPath: decoder.codingPath, debugDescription: "Unable to decode instance of RunStepDeltaStepDetailsToolCallsObjectToolCallsInner"))
        }
    }
}

