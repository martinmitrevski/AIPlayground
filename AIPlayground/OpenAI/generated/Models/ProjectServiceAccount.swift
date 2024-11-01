//
// ProjectServiceAccount.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
/** Represents an individual service account in a project. */

public struct ProjectServiceAccount: Codable, JSONEncodable, Hashable {
    public enum Object: String, Codable, CaseIterable {
        case organizationPeriodProjectPeriodServiceAccount = "organization.project.service_account"
    }
    public enum Role: String, Codable, CaseIterable {
        case owner = "owner"
        case member = "member"
    }
    /** The object type, which is always `organization.project.service_account` */
    public var object: Object
    /** The identifier, which can be referenced in API endpoints */
    public var id: String
    /** The name of the service account */
    public var name: String
    /** `owner` or `member` */
    public var role: Role
    /** The Unix timestamp (in seconds) of when the service account was created */
    public var createdAt: Int

    public init(object: Object, id: String, name: String, role: Role, createdAt: Int) {
        self.object = object
        self.id = id
        self.name = name
        self.role = role
        self.createdAt = createdAt
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case object
        case id
        case name
        case role
        case createdAt = "created_at"
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(object, forKey: .object)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(role, forKey: .role)
        try container.encode(createdAt, forKey: .createdAt)
    }
}

