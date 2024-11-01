//
// Embedding.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
/** Represents an embedding vector returned by embedding endpoint.  */

public struct Embedding: Codable, JSONEncodable, Hashable {
    public enum Object: String, Codable, CaseIterable {
        case embedding = "embedding"
    }
    /** The index of the embedding in the list of embeddings. */
    public var index: Int
    /** The embedding vector, which is a list of floats. The length of vector depends on the model as listed in the [embedding guide](/docs/guides/embeddings).  */
    public var embedding: [Double]
    /** The object type, which is always \"embedding\". */
    public var object: Object

    public init(index: Int, embedding: [Double], object: Object) {
        self.index = index
        self.embedding = embedding
        self.object = object
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case index
        case embedding
        case object
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(index, forKey: .index)
        try container.encode(embedding, forKey: .embedding)
        try container.encode(object, forKey: .object)
    }
}

