//
// ChatCompletionRequestFunctionMessage.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation

@available(*, deprecated, message: "This schema is deprecated.")

public struct ChatCompletionRequestFunctionMessage: Codable, JSONEncodable, Hashable {
    public enum Role: String, Codable, CaseIterable {
        case function = "function"
    }
    /** The role of the messages author, in this case `function`. */
    public var role: Role
    /** The contents of the function message. */
    public var content: String?
    /** The name of the function to call. */
    public var name: String

    public init(role: Role, content: String?, name: String) {
        self.role = role
        self.content = content
        self.name = name
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case role
        case content
        case name
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(role, forKey: .role)
        try container.encode(content, forKey: .content)
        try container.encode(name, forKey: .name)
    }
}
