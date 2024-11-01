//
// FineTuningJobIntegrationsInner.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation



public enum FineTuningJobIntegrationsInner: Codable, JSONEncodable, Hashable {
    case typeFineTuningIntegration(FineTuningIntegration)
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .typeFineTuningIntegration(let value):
            try container.encode(value)
        }
    }


    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
                if let value = try? container.decode(FineTuningIntegration.self) {
            self = .typeFineTuningIntegration(value)
        } else {
            throw DecodingError.typeMismatch(Self.Type.self, .init(codingPath: decoder.codingPath, debugDescription: "Unable to decode instance of FineTuningJobIntegrationsInner"))
        }
    }
}
