//
// FineTuningJobEvent.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
/** Fine-tuning job event object */

public struct FineTuningJobEvent: Codable, JSONEncodable, Hashable {
    public enum Level: String, Codable, CaseIterable {
        case info = "info"
        case warn = "warn"
        case error = "error"
    }
    public enum Object: String, Codable, CaseIterable {
        case fineTuningPeriodJobPeriodEvent = "fine_tuning.job.event"
    }
    public var id: String
    public var createdAt: Int
    public var level: Level
    public var message: String
    public var object: Object

    public init(id: String, createdAt: Int, level: Level, message: String, object: Object) {
        self.id = id
        self.createdAt = createdAt
        self.level = level
        self.message = message
        self.object = object
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case createdAt = "created_at"
        case level
        case message
        case object
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(level, forKey: .level)
        try container.encode(message, forKey: .message)
        try container.encode(object, forKey: .object)
    }
}

