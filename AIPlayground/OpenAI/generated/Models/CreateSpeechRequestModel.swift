//
// CreateSpeechRequestModel.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
/** One of the available [TTS models](/docs/models/tts): &#x60;tts-1&#x60; or &#x60;tts-1-hd&#x60;  */

public struct CreateSpeechRequestModel: Codable, JSONEncodable, Hashable {

    public enum CodingKeys: CodingKey, CaseIterable {
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
    }
}
