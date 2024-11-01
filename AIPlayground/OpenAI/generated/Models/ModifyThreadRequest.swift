//
// ModifyThreadRequest.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation


public struct ModifyThreadRequest: Codable, JSONEncodable, Hashable {
    public var toolResources: ThreadObjectToolResources?
    /** Set of 16 key-value pairs that can be attached to an object. This can be useful for storing additional information about the object in a structured format. Keys can be a maximum of 64 characters long and values can be a maximum of 512 characters long.  */
    public var metadata: [String: RawJSON]?

    public init(toolResources: ThreadObjectToolResources? = nil, metadata: [String: RawJSON]? = nil) {
        self.toolResources = toolResources
        self.metadata = metadata
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case toolResources = "tool_resources"
        case metadata
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(toolResources, forKey: .toolResources)
        try container.encodeIfPresent(metadata, forKey: .metadata)
    }
}

