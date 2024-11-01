//
// MessageContentTextAnnotationsFileCitationObjectFileCitation.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation


public struct MessageContentTextAnnotationsFileCitationObjectFileCitation: Codable, JSONEncodable, Hashable {
    /** The ID of the specific File the citation is from. */
    public var fileId: String

    public init(fileId: String) {
        self.fileId = fileId
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case fileId = "file_id"
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(fileId, forKey: .fileId)
    }
}
