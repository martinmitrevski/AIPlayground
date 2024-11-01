//
// FineTuningIntegration.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation


public struct FineTuningIntegration: Codable, JSONEncodable, Hashable {
    public enum ModelType: String, Codable, CaseIterable {
        case wandb = "wandb"
    }
    /** The type of the integration being enabled for the fine-tuning job */
    public var type: ModelType
    public var wandb: CreateFineTuningJobRequestIntegrationsInnerWandb

    public init(type: ModelType, wandb: CreateFineTuningJobRequestIntegrationsInnerWandb) {
        self.type = type
        self.wandb = wandb
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case type
        case wandb
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(wandb, forKey: .wandb)
    }
}
