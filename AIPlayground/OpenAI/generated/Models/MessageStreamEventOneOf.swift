//
// MessageStreamEventOneOf.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
/** Occurs when a [message](/docs/api-reference/messages/object) is created. */

public struct MessageStreamEventOneOf: Codable, JSONEncodable, Hashable {
    public enum Event: String, Codable, CaseIterable {
        case threadPeriodMessagePeriodCreated = "thread.message.created"
    }
    public var event: Event
    public var data: MessageObject

    public init(event: Event, data: MessageObject) {
        self.event = event
        self.data = data
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case event
        case data
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(event, forKey: .event)
        try container.encode(data, forKey: .data)
    }
}

