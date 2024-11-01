//
// AuditLogProjectArchived.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
/** The details for events with this &#x60;type&#x60;. */

public struct AuditLogProjectArchived: Codable, JSONEncodable, Hashable {
    /** The project ID. */
    public var id: String?

    public init(id: String? = nil) {
        self.id = id
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case id
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
    }
}

