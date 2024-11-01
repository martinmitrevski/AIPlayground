//
// MessageDeltaContentTextAnnotationsFileCitationObjectFileCitation.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation


public struct MessageDeltaContentTextAnnotationsFileCitationObjectFileCitation: Codable, JSONEncodable, Hashable {
    /** The ID of the specific File the citation is from. */
    public var fileId: String?
    /** The specific quote in the file. */
    public var quote: String?

    public init(fileId: String? = nil, quote: String? = nil) {
        self.fileId = fileId
        self.quote = quote
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case fileId = "file_id"
        case quote
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(fileId, forKey: .fileId)
        try container.encodeIfPresent(quote, forKey: .quote)
    }
}
