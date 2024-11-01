//
// MessageRequestContentTextObject.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
/** The text content that is part of a message. */

public struct MessageRequestContentTextObject: Codable, JSONEncodable, Hashable {
    public enum ModelType: String, Codable, CaseIterable {
        case text = "text"
    }
    /** Always `text`. */
    public var type: ModelType
    /** Text content to be sent to the model */
    public var text: String

    public init(type: ModelType, text: String) {
        self.type = type
        self.text = text
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case type
        case text
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(text, forKey: .text)
    }
}

