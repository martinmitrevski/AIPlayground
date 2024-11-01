//
// DeleteVectorStoreResponse.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation


public struct DeleteVectorStoreResponse: Codable, JSONEncodable, Hashable {
    public enum Object: String, Codable, CaseIterable {
        case vectorStorePeriodDeleted = "vector_store.deleted"
    }
    public var id: String
    public var deleted: Bool
    public var object: Object

    public init(id: String, deleted: Bool, object: Object) {
        self.id = id
        self.deleted = deleted
        self.object = object
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case deleted
        case object
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(deleted, forKey: .deleted)
        try container.encode(object, forKey: .object)
    }
}
