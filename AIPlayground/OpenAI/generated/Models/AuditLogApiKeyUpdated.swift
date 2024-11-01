//
// AuditLogApiKeyUpdated.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
/** The details for events with this &#x60;type&#x60;. */

public struct AuditLogApiKeyUpdated: Codable, JSONEncodable, Hashable {
    /** The tracking ID of the API key. */
    public var id: String?
    public var changesRequested: AuditLogApiKeyUpdatedChangesRequested?

    public init(id: String? = nil, changesRequested: AuditLogApiKeyUpdatedChangesRequested? = nil) {
        self.id = id
        self.changesRequested = changesRequested
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case changesRequested = "changes_requested"
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(changesRequested, forKey: .changesRequested)
    }
}

