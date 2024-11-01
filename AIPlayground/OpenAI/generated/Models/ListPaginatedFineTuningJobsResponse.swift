//
// ListPaginatedFineTuningJobsResponse.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation


public struct ListPaginatedFineTuningJobsResponse: Codable, JSONEncodable, Hashable {
    public enum Object: String, Codable, CaseIterable {
        case list = "list"
    }
    public var data: [FineTuningJob]
    public var hasMore: Bool
    public var object: Object

    public init(data: [FineTuningJob], hasMore: Bool, object: Object) {
        self.data = data
        self.hasMore = hasMore
        self.object = object
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case data
        case hasMore = "has_more"
        case object
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(data, forKey: .data)
        try container.encode(hasMore, forKey: .hasMore)
        try container.encode(object, forKey: .object)
    }
}

