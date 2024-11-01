//
// MessageContentRefusalObject.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
/** The refusal content generated by the assistant. */

public struct MessageContentRefusalObject: Codable, JSONEncodable, Hashable {
    public enum ModelType: String, Codable, CaseIterable {
        case refusal = "refusal"
    }
    /** Always `refusal`. */
    public var type: ModelType
    public var refusal: String

    public init(type: ModelType, refusal: String) {
        self.type = type
        self.refusal = refusal
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case type
        case refusal
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(refusal, forKey: .refusal)
    }
}

