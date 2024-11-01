//
// ThreadObjectToolResources.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
/** A set of resources that are made available to the assistant&#39;s tools in this thread. The resources are specific to the type of tool. For example, the &#x60;code_interpreter&#x60; tool requires a list of file IDs, while the &#x60;file_search&#x60; tool requires a list of vector store IDs.  */

public struct ThreadObjectToolResources: Codable, JSONEncodable, Hashable {
    public var codeInterpreter: CreateAssistantRequestToolResourcesCodeInterpreter?
    public var fileSearch: ThreadObjectToolResourcesFileSearch?

    public init(codeInterpreter: CreateAssistantRequestToolResourcesCodeInterpreter? = nil, fileSearch: ThreadObjectToolResourcesFileSearch? = nil) {
        self.codeInterpreter = codeInterpreter
        self.fileSearch = fileSearch
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case codeInterpreter = "code_interpreter"
        case fileSearch = "file_search"
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(codeInterpreter, forKey: .codeInterpreter)
        try container.encodeIfPresent(fileSearch, forKey: .fileSearch)
    }
}

