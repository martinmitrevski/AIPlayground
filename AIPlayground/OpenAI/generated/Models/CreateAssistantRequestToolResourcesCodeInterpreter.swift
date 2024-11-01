//
// CreateAssistantRequestToolResourcesCodeInterpreter.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation


public struct CreateAssistantRequestToolResourcesCodeInterpreter: Codable, JSONEncodable, Hashable {
    /** A list of [file](/docs/api-reference/files) IDs made available to the `code_interpreter` tool. There can be a maximum of 20 files associated with the tool.  */
    public var fileIds: [String]?

    public init(fileIds: [String]? = nil) {
        self.fileIds = fileIds
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case fileIds = "file_ids"
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(fileIds, forKey: .fileIds)
    }
}

