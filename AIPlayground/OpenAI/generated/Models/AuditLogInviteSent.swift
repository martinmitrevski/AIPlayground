//
// AuditLogInviteSent.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
/** The details for events with this &#x60;type&#x60;. */

public struct AuditLogInviteSent: Codable, JSONEncodable, Hashable {
    /** The ID of the invite. */
    public var id: String?
    public var data: AuditLogInviteSentData?

    public init(id: String? = nil, data: AuditLogInviteSentData? = nil) {
        self.id = id
        self.data = data
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case data
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(data, forKey: .data)
    }
}

