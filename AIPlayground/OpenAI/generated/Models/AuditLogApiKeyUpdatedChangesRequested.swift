//
// AuditLogApiKeyUpdatedChangesRequested.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
/** The payload used to update the API key. */

public struct AuditLogApiKeyUpdatedChangesRequested: Codable, JSONEncodable, Hashable {
    /** A list of scopes allowed for the API key, e.g. `[\"api.model.request\"]` */
    public var scopes: [String]?

    public init(scopes: [String]? = nil) {
        self.scopes = scopes
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case scopes
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(scopes, forKey: .scopes)
    }
}

