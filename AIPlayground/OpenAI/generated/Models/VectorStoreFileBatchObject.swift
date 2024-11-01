//
// VectorStoreFileBatchObject.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
/** A batch of files attached to a vector store. */

public struct VectorStoreFileBatchObject: Codable, JSONEncodable, Hashable {
    public enum Object: String, Codable, CaseIterable {
        case vectorStorePeriodFilesBatch = "vector_store.files_batch"
    }
    public enum Status: String, Codable, CaseIterable {
        case inProgress = "in_progress"
        case completed = "completed"
        case cancelled = "cancelled"
        case failed = "failed"
    }
    /** The identifier, which can be referenced in API endpoints. */
    public var id: String
    /** The object type, which is always `vector_store.file_batch`. */
    public var object: Object
    /** The Unix timestamp (in seconds) for when the vector store files batch was created. */
    public var createdAt: Int
    /** The ID of the [vector store](/docs/api-reference/vector-stores/object) that the [File](/docs/api-reference/files) is attached to. */
    public var vectorStoreId: String
    /** The status of the vector store files batch, which can be either `in_progress`, `completed`, `cancelled` or `failed`. */
    public var status: Status
    public var fileCounts: VectorStoreFileBatchObjectFileCounts

    public init(id: String, object: Object, createdAt: Int, vectorStoreId: String, status: Status, fileCounts: VectorStoreFileBatchObjectFileCounts) {
        self.id = id
        self.object = object
        self.createdAt = createdAt
        self.vectorStoreId = vectorStoreId
        self.status = status
        self.fileCounts = fileCounts
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case object
        case createdAt = "created_at"
        case vectorStoreId = "vector_store_id"
        case status
        case fileCounts = "file_counts"
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(object, forKey: .object)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(vectorStoreId, forKey: .vectorStoreId)
        try container.encode(status, forKey: .status)
        try container.encode(fileCounts, forKey: .fileCounts)
    }
}
