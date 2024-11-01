//
// MessageContentTextObjectTextAnnotationsInner.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation



public enum MessageContentTextObjectTextAnnotationsInner: Codable, JSONEncodable, Hashable {
    case typeMessageContentTextAnnotationsFileCitationObject(MessageContentTextAnnotationsFileCitationObject)
    case typeMessageContentTextAnnotationsFilePathObject(MessageContentTextAnnotationsFilePathObject)
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .typeMessageContentTextAnnotationsFileCitationObject(let value):
            try container.encode(value)
        case .typeMessageContentTextAnnotationsFilePathObject(let value):
            try container.encode(value)
        }
    }


    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
                if let value = try? container.decode(MessageContentTextAnnotationsFileCitationObject.self) {
            self = .typeMessageContentTextAnnotationsFileCitationObject(value)
                } else if let value = try? container.decode(MessageContentTextAnnotationsFilePathObject.self) {
            self = .typeMessageContentTextAnnotationsFilePathObject(value)
        } else {
            throw DecodingError.typeMismatch(Self.Type.self, .init(codingPath: decoder.codingPath, debugDescription: "Unable to decode instance of MessageContentTextObjectTextAnnotationsInner"))
        }
    }
}

