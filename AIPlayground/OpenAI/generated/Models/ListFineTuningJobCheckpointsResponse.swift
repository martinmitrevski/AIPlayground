//
// ListFineTuningJobCheckpointsResponse.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation


public struct ListFineTuningJobCheckpointsResponse: Codable, JSONEncodable, Hashable {
    public enum Object: String, Codable, CaseIterable {
        case list = "list"
    }
    public var data: [FineTuningJobCheckpoint]
    public var object: Object
    public var firstId: String?
    public var lastId: String?
    public var hasMore: Bool

    public init(data: [FineTuningJobCheckpoint], object: Object, firstId: String? = nil, lastId: String? = nil, hasMore: Bool) {
        self.data = data
        self.object = object
        self.firstId = firstId
        self.lastId = lastId
        self.hasMore = hasMore
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case data
        case object
        case firstId = "first_id"
        case lastId = "last_id"
        case hasMore = "has_more"
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(data, forKey: .data)
        try container.encode(object, forKey: .object)
        try container.encodeIfPresent(firstId, forKey: .firstId)
        try container.encodeIfPresent(lastId, forKey: .lastId)
        try container.encode(hasMore, forKey: .hasMore)
    }
}

