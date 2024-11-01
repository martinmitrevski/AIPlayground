//
// CreateAssistantRequest.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation


public struct CreateAssistantRequest: Codable, JSONEncodable, Hashable {
    public var model: String
    /** The name of the assistant. The maximum length is 256 characters.  */
    public var name: String?
    /** The description of the assistant. The maximum length is 512 characters.  */
    public var description: String?
    /** The system instructions that the assistant uses. The maximum length is 256,000 characters.  */
    public var instructions: String?
    /** A list of tool enabled on the assistant. There can be a maximum of 128 tools per assistant. Tools can be of types `code_interpreter`, `file_search`, or `function`.  */
    public var tools: [AssistantObjectToolsInner]?
    public var toolResources: CreateAssistantRequestToolResources?
    /** Set of 16 key-value pairs that can be attached to an object. This can be useful for storing additional information about the object in a structured format. Keys can be a maximum of 64 characters long and values can be a maximum of 512 characters long.  */
    public var metadata: [String: RawJSON]?
    /** What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic.  */
    public var temperature: Double? = 1
    /** An alternative to sampling with temperature, called nucleus sampling, where the model considers the results of the tokens with top_p probability mass. So 0.1 means only the tokens comprising the top 10% probability mass are considered.  We generally recommend altering this or temperature but not both.  */
    public var topP: Double? = 1
    public var responseFormat: AssistantsApiResponseFormatOption?

    public init(model: String, name: String? = nil, description: String? = nil, instructions: String? = nil, tools: [AssistantObjectToolsInner]? = nil, toolResources: CreateAssistantRequestToolResources? = nil, metadata: [String: RawJSON]? = nil, temperature: Double? = 1, topP: Double? = 1, responseFormat: AssistantsApiResponseFormatOption? = nil) {
        self.model = model
        self.name = name
        self.description = description
        self.instructions = instructions
        self.tools = tools
        self.toolResources = toolResources
        self.metadata = metadata
        self.temperature = temperature
        self.topP = topP
        self.responseFormat = responseFormat
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case model
        case name
        case description
        case instructions
        case tools
        case toolResources = "tool_resources"
        case metadata
        case temperature
        case topP = "top_p"
        case responseFormat = "response_format"
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(model, forKey: .model)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(instructions, forKey: .instructions)
        try container.encodeIfPresent(tools, forKey: .tools)
        try container.encodeIfPresent(toolResources, forKey: .toolResources)
        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encodeIfPresent(temperature, forKey: .temperature)
        try container.encodeIfPresent(topP, forKey: .topP)
        try container.encodeIfPresent(responseFormat, forKey: .responseFormat)
    }
}

