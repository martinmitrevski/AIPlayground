//
// RunStepDetailsToolCallsCodeObjectCodeInterpreterOutputsInner.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation



public enum RunStepDetailsToolCallsCodeObjectCodeInterpreterOutputsInner: Codable, JSONEncodable, Hashable {
    case typeRunStepDetailsToolCallsCodeOutputImageObject(RunStepDetailsToolCallsCodeOutputImageObject)
    case typeRunStepDetailsToolCallsCodeOutputLogsObject(RunStepDetailsToolCallsCodeOutputLogsObject)
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .typeRunStepDetailsToolCallsCodeOutputImageObject(let value):
            try container.encode(value)
        case .typeRunStepDetailsToolCallsCodeOutputLogsObject(let value):
            try container.encode(value)
        }
    }


    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
                if let value = try? container.decode(RunStepDetailsToolCallsCodeOutputImageObject.self) {
            self = .typeRunStepDetailsToolCallsCodeOutputImageObject(value)
                } else if let value = try? container.decode(RunStepDetailsToolCallsCodeOutputLogsObject.self) {
            self = .typeRunStepDetailsToolCallsCodeOutputLogsObject(value)
        } else {
            throw DecodingError.typeMismatch(Self.Type.self, .init(codingPath: decoder.codingPath, debugDescription: "Unable to decode instance of RunStepDetailsToolCallsCodeObjectCodeInterpreterOutputsInner"))
        }
    }
}

