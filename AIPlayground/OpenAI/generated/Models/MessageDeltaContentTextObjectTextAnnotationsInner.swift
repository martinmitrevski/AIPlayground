//
// MessageDeltaContentTextObjectTextAnnotationsInner.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation



public enum MessageDeltaContentTextObjectTextAnnotationsInner: Codable, JSONEncodable, Hashable {
    case typeMessageDeltaContentTextAnnotationsFileCitationObject(MessageDeltaContentTextAnnotationsFileCitationObject)
    case typeMessageDeltaContentTextAnnotationsFilePathObject(MessageDeltaContentTextAnnotationsFilePathObject)
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .typeMessageDeltaContentTextAnnotationsFileCitationObject(let value):
            try container.encode(value)
        case .typeMessageDeltaContentTextAnnotationsFilePathObject(let value):
            try container.encode(value)
        }
    }


    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
                if let value = try? container.decode(MessageDeltaContentTextAnnotationsFileCitationObject.self) {
            self = .typeMessageDeltaContentTextAnnotationsFileCitationObject(value)
                } else if let value = try? container.decode(MessageDeltaContentTextAnnotationsFilePathObject.self) {
            self = .typeMessageDeltaContentTextAnnotationsFilePathObject(value)
        } else {
            throw DecodingError.typeMismatch(Self.Type.self, .init(codingPath: decoder.codingPath, debugDescription: "Unable to decode instance of MessageDeltaContentTextObjectTextAnnotationsInner"))
        }
    }
}

