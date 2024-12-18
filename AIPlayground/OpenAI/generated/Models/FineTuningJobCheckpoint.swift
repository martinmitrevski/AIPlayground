//
// FineTuningJobCheckpoint.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
/** The &#x60;fine_tuning.job.checkpoint&#x60; object represents a model checkpoint for a fine-tuning job that is ready to use.  */

public struct FineTuningJobCheckpoint: Codable, JSONEncodable, Hashable {
    public enum Object: String, Codable, CaseIterable {
        case fineTuningPeriodJobPeriodCheckpoint = "fine_tuning.job.checkpoint"
    }
    /** The checkpoint identifier, which can be referenced in the API endpoints. */
    public var id: String
    /** The Unix timestamp (in seconds) for when the checkpoint was created. */
    public var createdAt: Int
    /** The name of the fine-tuned checkpoint model that is created. */
    public var fineTunedModelCheckpoint: String
    /** The step number that the checkpoint was created at. */
    public var stepNumber: Int
    public var metrics: FineTuningJobCheckpointMetrics
    /** The name of the fine-tuning job that this checkpoint was created from. */
    public var fineTuningJobId: String
    /** The object type, which is always \"fine_tuning.job.checkpoint\". */
    public var object: Object

    public init(id: String, createdAt: Int, fineTunedModelCheckpoint: String, stepNumber: Int, metrics: FineTuningJobCheckpointMetrics, fineTuningJobId: String, object: Object) {
        self.id = id
        self.createdAt = createdAt
        self.fineTunedModelCheckpoint = fineTunedModelCheckpoint
        self.stepNumber = stepNumber
        self.metrics = metrics
        self.fineTuningJobId = fineTuningJobId
        self.object = object
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case createdAt = "created_at"
        case fineTunedModelCheckpoint = "fine_tuned_model_checkpoint"
        case stepNumber = "step_number"
        case metrics
        case fineTuningJobId = "fine_tuning_job_id"
        case object
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(fineTunedModelCheckpoint, forKey: .fineTunedModelCheckpoint)
        try container.encode(stepNumber, forKey: .stepNumber)
        try container.encode(metrics, forKey: .metrics)
        try container.encode(fineTuningJobId, forKey: .fineTuningJobId)
        try container.encode(object, forKey: .object)
    }
}

