//
// Invite.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
/** Represents an individual &#x60;invite&#x60; to the organization. */

public struct Invite: Codable, JSONEncodable, Hashable {
    public enum Object: String, Codable, CaseIterable {
        case organizationPeriodInvite = "organization.invite"
    }
    public enum Role: String, Codable, CaseIterable {
        case owner = "owner"
        case reader = "reader"
    }
    public enum Status: String, Codable, CaseIterable {
        case accepted = "accepted"
        case expired = "expired"
        case pending = "pending"
    }
    /** The object type, which is always `organization.invite` */
    public var object: Object
    /** The identifier, which can be referenced in API endpoints */
    public var id: String
    /** The email address of the individual to whom the invite was sent */
    public var email: String
    /** `owner` or `reader` */
    public var role: Role
    /** `accepted`,`expired`, or `pending` */
    public var status: Status
    /** The Unix timestamp (in seconds) of when the invite was sent. */
    public var invitedAt: Int
    /** The Unix timestamp (in seconds) of when the invite expires. */
    public var expiresAt: Int
    /** The Unix timestamp (in seconds) of when the invite was accepted. */
    public var acceptedAt: Int?

    public init(object: Object, id: String, email: String, role: Role, status: Status, invitedAt: Int, expiresAt: Int, acceptedAt: Int? = nil) {
        self.object = object
        self.id = id
        self.email = email
        self.role = role
        self.status = status
        self.invitedAt = invitedAt
        self.expiresAt = expiresAt
        self.acceptedAt = acceptedAt
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case object
        case id
        case email
        case role
        case status
        case invitedAt = "invited_at"
        case expiresAt = "expires_at"
        case acceptedAt = "accepted_at"
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(object, forKey: .object)
        try container.encode(id, forKey: .id)
        try container.encode(email, forKey: .email)
        try container.encode(role, forKey: .role)
        try container.encode(status, forKey: .status)
        try container.encode(invitedAt, forKey: .invitedAt)
        try container.encode(expiresAt, forKey: .expiresAt)
        try container.encodeIfPresent(acceptedAt, forKey: .acceptedAt)
    }
}
