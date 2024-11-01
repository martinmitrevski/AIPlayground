//
// ProjectApiKeyOwner.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation


public struct ProjectApiKeyOwner: Codable, JSONEncodable, Hashable {
    public enum ModelType: String, Codable, CaseIterable {
        case user = "user"
        case serviceAccount = "service_account"
    }
    /** `user` or `service_account` */
    public var type: ModelType?
    public var user: ProjectUser?
    public var serviceAccount: ProjectServiceAccount?

    public init(type: ModelType? = nil, user: ProjectUser? = nil, serviceAccount: ProjectServiceAccount? = nil) {
        self.type = type
        self.user = user
        self.serviceAccount = serviceAccount
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case type
        case user
        case serviceAccount = "service_account"
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(type, forKey: .type)
        try container.encodeIfPresent(user, forKey: .user)
        try container.encodeIfPresent(serviceAccount, forKey: .serviceAccount)
    }
}

