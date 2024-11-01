//
// CreateAssistantRequestToolResourcesFileSearch.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation



public enum CreateAssistantRequestToolResourcesFileSearch: Codable, JSONEncodable, Hashable {
    case typeRawJSON(RawJSON)
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .typeRawJSON(let value):
            try container.encode(value)
        }
    }


    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
                if let value = try? container.decode(RawJSON.self) {
            self = .typeRawJSON(value)
        } else {
            throw DecodingError.typeMismatch(Self.Type.self, .init(codingPath: decoder.codingPath, debugDescription: "Unable to decode instance of CreateAssistantRequestToolResourcesFileSearch"))
        }
    }
}

