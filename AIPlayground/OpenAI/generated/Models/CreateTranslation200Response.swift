//
// CreateTranslation200Response.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation



public enum CreateTranslation200Response: Codable, JSONEncodable, Hashable {
    case typeCreateTranslationResponseJson(CreateTranslationResponseJson)
    case typeCreateTranslationResponseVerboseJson(CreateTranslationResponseVerboseJson)
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .typeCreateTranslationResponseJson(let value):
            try container.encode(value)
        case .typeCreateTranslationResponseVerboseJson(let value):
            try container.encode(value)
        }
    }


    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
                if let value = try? container.decode(CreateTranslationResponseJson.self) {
            self = .typeCreateTranslationResponseJson(value)
                } else if let value = try? container.decode(CreateTranslationResponseVerboseJson.self) {
            self = .typeCreateTranslationResponseVerboseJson(value)
        } else {
            throw DecodingError.typeMismatch(Self.Type.self, .init(codingPath: decoder.codingPath, debugDescription: "Unable to decode instance of CreateTranslation200Response"))
        }
    }
}

