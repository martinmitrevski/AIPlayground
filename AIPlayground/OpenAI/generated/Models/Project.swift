//
// Project.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
/** Represents an individual project. */

public struct Project: Codable, JSONEncodable, Hashable {
    public enum Object: String, Codable, CaseIterable {
        case organizationPeriodProject = "organization.project"
    }
    public enum Status: String, Codable, CaseIterable {
        case active = "active"
        case archived = "archived"
    }
    /** The identifier, which can be referenced in API endpoints */
    public var id: String
    /** The object type, which is always `organization.project` */
    public var object: Object
    /** The name of the project. This appears in reporting. */
    public var name: String
    /** The Unix timestamp (in seconds) of when the project was created. */
    public var createdAt: Int
    /** The Unix timestamp (in seconds) of when the project was archived or `null`. */
    public var archivedAt: Int?
    /** `active` or `archived` */
    public var status: Status

    public init(id: String, object: Object, name: String, createdAt: Int, archivedAt: Int? = nil, status: Status) {
        self.id = id
        self.object = object
        self.name = name
        self.createdAt = createdAt
        self.archivedAt = archivedAt
        self.status = status
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case object
        case name
        case createdAt = "created_at"
        case archivedAt = "archived_at"
        case status
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(object, forKey: .object)
        try container.encode(name, forKey: .name)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encodeIfPresent(archivedAt, forKey: .archivedAt)
        try container.encode(status, forKey: .status)
    }
}

