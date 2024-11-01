//
// AuditLogServiceAccountUpdated.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
/** The details for events with this &#x60;type&#x60;. */

public struct AuditLogServiceAccountUpdated: Codable, JSONEncodable, Hashable {
    /** The service account ID. */
    public var id: String?
    public var changesRequested: AuditLogServiceAccountUpdatedChangesRequested?

    public init(id: String? = nil, changesRequested: AuditLogServiceAccountUpdatedChangesRequested? = nil) {
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
