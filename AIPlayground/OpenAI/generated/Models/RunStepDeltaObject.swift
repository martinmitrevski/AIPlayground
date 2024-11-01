//
// RunStepDeltaObject.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
/** Represents a run step delta i.e. any changed fields on a run step during streaming.  */

public struct RunStepDeltaObject: Codable, JSONEncodable, Hashable {
    public enum Object: String, Codable, CaseIterable {
        case threadPeriodRunPeriodStepPeriodDelta = "thread.run.step.delta"
    }
    /** The identifier of the run step, which can be referenced in API endpoints. */
    public var id: String
    /** The object type, which is always `thread.run.step.delta`. */
    public var object: Object
    public var delta: RunStepDeltaObjectDelta

    public init(id: String, object: Object, delta: RunStepDeltaObjectDelta) {
        self.id = id
        self.object = object
        self.delta = delta
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case object
        case delta
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(object, forKey: .object)
        try container.encode(delta, forKey: .delta)
    }
}

