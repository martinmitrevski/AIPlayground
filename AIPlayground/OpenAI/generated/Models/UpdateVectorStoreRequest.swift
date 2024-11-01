//
// UpdateVectorStoreRequest.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation


public struct UpdateVectorStoreRequest: Codable, JSONEncodable, Hashable {
    /** The name of the vector store. */
    public var name: String?
    public var expiresAfter: VectorStoreExpirationAfter?
    /** Set of 16 key-value pairs that can be attached to an object. This can be useful for storing additional information about the object in a structured format. Keys can be a maximum of 64 characters long and values can be a maximum of 512 characters long.  */
    public var metadata: [String: RawJSON]?

    public init(name: String? = nil, expiresAfter: VectorStoreExpirationAfter? = nil, metadata: [String: RawJSON]? = nil) {
        self.name = name
        self.expiresAfter = expiresAfter
        self.metadata = metadata
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case name
        case expiresAfter = "expires_after"
        case metadata
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(expiresAfter, forKey: .expiresAfter)
        try container.encodeIfPresent(metadata, forKey: .metadata)
    }
}

