//
// RunStepDeltaStepDetailsMessageCreationObjectMessageCreation.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation


public struct RunStepDeltaStepDetailsMessageCreationObjectMessageCreation: Codable, JSONEncodable, Hashable {
    /** The ID of the message that was created by this run step. */
    public var messageId: String?

    public init(messageId: String? = nil) {
        self.messageId = messageId
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case messageId = "message_id"
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(messageId, forKey: .messageId)
    }
}
