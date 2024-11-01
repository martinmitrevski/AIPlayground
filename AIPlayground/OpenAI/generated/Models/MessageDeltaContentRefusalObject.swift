//
// MessageDeltaContentRefusalObject.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
/** The refusal content that is part of a message. */

public struct MessageDeltaContentRefusalObject: Codable, JSONEncodable, Hashable {
    public enum ModelType: String, Codable, CaseIterable {
        case refusal = "refusal"
    }
    /** The index of the refusal part in the message. */
    public var index: Int
    /** Always `refusal`. */
    public var type: ModelType
    public var refusal: String?

    public init(index: Int, type: ModelType, refusal: String? = nil) {
        self.index = index
        self.type = type
        self.refusal = refusal
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case index
        case type
        case refusal
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(index, forKey: .index)
        try container.encode(type, forKey: .type)
        try container.encodeIfPresent(refusal, forKey: .refusal)
    }
}
