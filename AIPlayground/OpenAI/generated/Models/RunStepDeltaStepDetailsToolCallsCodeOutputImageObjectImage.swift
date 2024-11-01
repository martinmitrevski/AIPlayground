//
// RunStepDeltaStepDetailsToolCallsCodeOutputImageObjectImage.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation


public struct RunStepDeltaStepDetailsToolCallsCodeOutputImageObjectImage: Codable, JSONEncodable, Hashable {
    /** The [file](/docs/api-reference/files) ID of the image. */
    public var fileId: String?

    public init(fileId: String? = nil) {
        self.fileId = fileId
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case fileId = "file_id"
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(fileId, forKey: .fileId)
    }
}

