//
// Image.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
/** Represents the url or the content of an image generated by the OpenAI API. */

public struct OpenAIImage: Codable, JSONEncodable, Hashable {
    /** The base64-encoded JSON of the generated image, if `response_format` is `b64_json`. */
    public var b64Json: String?
    /** The URL of the generated image, if `response_format` is `url` (default). */
    public var url: String?
    /** The prompt that was used to generate the image, if there was any revision to the prompt. */
    public var revisedPrompt: String?

    public init(b64Json: String? = nil, url: String? = nil, revisedPrompt: String? = nil) {
        self.b64Json = b64Json
        self.url = url
        self.revisedPrompt = revisedPrompt
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case b64Json = "b64_json"
        case url
        case revisedPrompt = "revised_prompt"
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(b64Json, forKey: .b64Json)
        try container.encodeIfPresent(url, forKey: .url)
        try container.encodeIfPresent(revisedPrompt, forKey: .revisedPrompt)
    }
}
