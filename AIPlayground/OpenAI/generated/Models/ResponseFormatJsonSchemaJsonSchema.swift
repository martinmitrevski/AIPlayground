//
// ResponseFormatJsonSchemaJsonSchema.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation


public struct ResponseFormatJsonSchemaJsonSchema: Codable, JSONEncodable, Hashable {
    /** A description of what the response format is for, used by the model to determine how to respond in the format. */
    public var description: String?
    /** The name of the response format. Must be a-z, A-Z, 0-9, or contain underscores and dashes, with a maximum length of 64. */
    public var name: String
    /** The schema for the response format, described as a JSON Schema object. */
    public var schema: [String: RawJSON]?
    /** Whether to enable strict schema adherence when generating the output. If set to true, the model will always follow the exact schema defined in the `schema` field. Only a subset of JSON Schema is supported when `strict` is `true`. To learn more, read the [Structured Outputs guide](/docs/guides/structured-outputs). */
    public var strict: Bool? = false

    public init(description: String? = nil, name: String, schema: [String: RawJSON]? = nil, strict: Bool? = false) {
        self.description = description
        self.name = name
        self.schema = schema
        self.strict = strict
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case description
        case name
        case schema
        case strict
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encode(name, forKey: .name)
        try container.encodeIfPresent(schema, forKey: .schema)
        try container.encodeIfPresent(strict, forKey: .strict)
    }
}

