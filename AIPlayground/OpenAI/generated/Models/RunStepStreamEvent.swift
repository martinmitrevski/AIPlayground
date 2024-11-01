//
// RunStepStreamEvent.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation



public enum RunStepStreamEvent: Codable, JSONEncodable, Hashable {
    case typeRunStepStreamEventOneOf(RunStepStreamEventOneOf)
    case typeRunStepStreamEventOneOf1(RunStepStreamEventOneOf1)
    case typeRunStepStreamEventOneOf2(RunStepStreamEventOneOf2)
    case typeRunStepStreamEventOneOf3(RunStepStreamEventOneOf3)
    case typeRunStepStreamEventOneOf4(RunStepStreamEventOneOf4)
    case typeRunStepStreamEventOneOf5(RunStepStreamEventOneOf5)
    case typeRunStepStreamEventOneOf6(RunStepStreamEventOneOf6)
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .typeRunStepStreamEventOneOf(let value):
            try container.encode(value)
        case .typeRunStepStreamEventOneOf1(let value):
            try container.encode(value)
        case .typeRunStepStreamEventOneOf2(let value):
            try container.encode(value)
        case .typeRunStepStreamEventOneOf3(let value):
            try container.encode(value)
        case .typeRunStepStreamEventOneOf4(let value):
            try container.encode(value)
        case .typeRunStepStreamEventOneOf5(let value):
            try container.encode(value)
        case .typeRunStepStreamEventOneOf6(let value):
            try container.encode(value)
        }
    }


    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
                if let value = try? container.decode(RunStepStreamEventOneOf.self) {
            self = .typeRunStepStreamEventOneOf(value)
                } else if let value = try? container.decode(RunStepStreamEventOneOf1.self) {
            self = .typeRunStepStreamEventOneOf1(value)
                } else if let value = try? container.decode(RunStepStreamEventOneOf2.self) {
            self = .typeRunStepStreamEventOneOf2(value)
                } else if let value = try? container.decode(RunStepStreamEventOneOf3.self) {
            self = .typeRunStepStreamEventOneOf3(value)
                } else if let value = try? container.decode(RunStepStreamEventOneOf4.self) {
            self = .typeRunStepStreamEventOneOf4(value)
                } else if let value = try? container.decode(RunStepStreamEventOneOf5.self) {
            self = .typeRunStepStreamEventOneOf5(value)
                } else if let value = try? container.decode(RunStepStreamEventOneOf6.self) {
            self = .typeRunStepStreamEventOneOf6(value)
        } else {
            throw DecodingError.typeMismatch(Self.Type.self, .init(codingPath: decoder.codingPath, debugDescription: "Unable to decode instance of RunStepStreamEvent"))
        }
    }
}
