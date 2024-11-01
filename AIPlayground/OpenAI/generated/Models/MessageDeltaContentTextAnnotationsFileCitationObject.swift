//
// MessageDeltaContentTextAnnotationsFileCitationObject.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
/** A citation within the message that points to a specific quote from a specific File associated with the assistant or the message. Generated when the assistant uses the \&quot;file_search\&quot; tool to search files. */

public struct MessageDeltaContentTextAnnotationsFileCitationObject: Codable, JSONEncodable, Hashable {
    public enum ModelType: String, Codable, CaseIterable {
        case fileCitation = "file_citation"
    }
    /** The index of the annotation in the text content part. */
    public var index: Int
    /** Always `file_citation`. */
    public var type: ModelType
    /** The text in the message content that needs to be replaced. */
    public var text: String?
    public var fileCitation: MessageDeltaContentTextAnnotationsFileCitationObjectFileCitation?
    public var startIndex: Int?
    public var endIndex: Int?

    public init(index: Int, type: ModelType, text: String? = nil, fileCitation: MessageDeltaContentTextAnnotationsFileCitationObjectFileCitation? = nil, startIndex: Int? = nil, endIndex: Int? = nil) {
        self.index = index
        self.type = type
        self.text = text
        self.fileCitation = fileCitation
        self.startIndex = startIndex
        self.endIndex = endIndex
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case index
        case type
        case text
        case fileCitation = "file_citation"
        case startIndex = "start_index"
        case endIndex = "end_index"
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(index, forKey: .index)
        try container.encode(type, forKey: .type)
        try container.encodeIfPresent(text, forKey: .text)
        try container.encodeIfPresent(fileCitation, forKey: .fileCitation)
        try container.encodeIfPresent(startIndex, forKey: .startIndex)
        try container.encodeIfPresent(endIndex, forKey: .endIndex)
    }
}

