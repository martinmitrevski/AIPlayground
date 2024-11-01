//
// MessageContentImageFileObjectImageFile.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation


public struct MessageContentImageFileObjectImageFile: Codable, JSONEncodable, Hashable {
    public enum Detail: String, Codable, CaseIterable {
        case auto = "auto"
        case low = "low"
        case high = "high"
    }
    /** The [File](/docs/api-reference/files) ID of the image in the message content. Set `purpose=\"vision\"` when uploading the File if you need to later display the file content. */
    public var fileId: String
    /** Specifies the detail level of the image if specified by the user. `low` uses fewer tokens, you can opt in to high resolution using `high`. */
    public var detail: Detail? = .auto

    public init(fileId: String, detail: Detail? = .auto) {
        self.fileId = fileId
        self.detail = detail
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case fileId = "file_id"
        case detail
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(fileId, forKey: .fileId)
        try container.encodeIfPresent(detail, forKey: .detail)
    }
}

