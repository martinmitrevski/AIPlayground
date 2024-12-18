//
// CreateMessageRequest.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation


public struct CreateMessageRequest: Codable, JSONEncodable, Hashable {
    public enum Role: String, Codable, CaseIterable {
        case user = "user"
        case assistant = "assistant"
    }
    /** The role of the entity that is creating the message. Allowed values include: - `user`: Indicates the message is sent by an actual user and should be used in most cases to represent user-generated messages. - `assistant`: Indicates the message is generated by the assistant. Use this value to insert messages from the assistant into the conversation.  */
    public var role: Role
    public var content: CreateMessageRequestContent
    /** A list of files attached to the message, and the tools they should be added to. */
    public var attachments: [MessageObjectAttachmentsInner]?
    /** Set of 16 key-value pairs that can be attached to an object. This can be useful for storing additional information about the object in a structured format. Keys can be a maximum of 64 characters long and values can be a maximum of 512 characters long.  */
    public var metadata: [String: RawJSON]?

    public init(role: Role, content: CreateMessageRequestContent, attachments: [MessageObjectAttachmentsInner]? = nil, metadata: [String: RawJSON]? = nil) {
        self.role = role
        self.content = content
        self.attachments = attachments
        self.metadata = metadata
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case role
        case content
        case attachments
        case metadata
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(role, forKey: .role)
        try container.encode(content, forKey: .content)
        try container.encodeIfPresent(attachments, forKey: .attachments)
        try container.encodeIfPresent(metadata, forKey: .metadata)
    }
}

