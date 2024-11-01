//
//  FilesAPI.swift
//  AIPlayground
//
//  Created by Martin Mitrevski on 14.10.24.
//

import Foundation

protocol FilesAPITransport: Sendable {
    func execute(request: Request) async throws -> (Data, URLResponse)
}

protocol FilesAPIClientMiddleware: Sendable {
    func intercept(
        _ request: Request,
        next: (Request) async throws -> (Data, URLResponse)
    ) async throws -> (Data, URLResponse)
}


open class FilesAPI: FilesAPIEndpoints, @unchecked Sendable {
    internal var transport: FilesAPITransport
    internal var middlewares: [FilesAPIClientMiddleware]
    internal var basePath: String
    internal var jsonDecoder: JSONDecoder

    init(basePath: String, transport: FilesAPITransport, middlewares: [FilesAPIClientMiddleware], jsonDecoder: JSONDecoder = JSONDecoder()) {
        self.basePath = basePath
        self.transport = transport
        self.middlewares = middlewares
        self.jsonDecoder = jsonDecoder
    }

    func send<Response: Codable>(
        request: Request,
        deserializer: (Data) throws -> Response
    ) async throws -> Response {

        // TODO: make this a bit nicer and create an API error to make it easier to handle stuff
        func makeError(_ error: Error) -> Error {
            return error
        }

        func wrappingErrors<R>(
            work: () async throws -> R,
            mapError: (Error) -> Error
        ) async throws -> R {
            do {
                return try await work()
            } catch {
                throw mapError(error)
            }
        }

        let (data, _) = try await wrappingErrors {
            var next: (Request) async throws -> (Data, URLResponse) = { _request in
                try await wrappingErrors {
                    try await self.transport.execute(request: _request)
                } mapError: { error in
                    makeError(error)
                }
            }
            for middleware in middlewares.reversed() {
                let tmp = next
                next = {
                    try await middleware.intercept(
                        $0,
                        next: tmp
                    )
                }
            }
            return try await next(request)
        } mapError: { error in
            makeError(error)
        }

        return try await wrappingErrors {
            try deserializer(data)
        } mapError: { error in
            makeError(error)
        }
    }

    func makeRequest(
        uriPath: String,
        queryParams: [URLQueryItem] = [],
        httpMethod: String
    ) throws -> Request {
        let url = URL(string: basePath + uriPath)!
        return Request(
            url: url,
            method: .init(stringValue: httpMethod),
            stream: false,
            queryParams: queryParams,
            headers: ["Content-Type": "application/json"]
        )
    }

    func makeRequest<T: Encodable>(
        uriPath: String,
        queryParams: [URLQueryItem] = [],
        httpMethod: String,
        request: T
    ) throws -> Request {
        var r = try makeRequest(uriPath: uriPath, queryParams: queryParams, httpMethod: httpMethod)
        r.body = try JSONEncoder().encode(request)
        return r
    }

    /**
     Upload a file that can be used across various endpoints. Individual files can be up to 512 MB, and the size of all files uploaded by one organization can be up to 100 GB.  The Assistants API supports files up to 2 million tokens and of specific file types. See the [Assistants Tools guide](/docs/assistants/tools) for details.  The Fine-tuning API only supports `.jsonl` files. The input also has certain required formats for fine-tuning [chat](/docs/api-reference/fine-tuning/chat-input) or [completions](/docs/api-reference/fine-tuning/completions-input) models.  The Batch API only supports `.jsonl` files up to 100 MB in size. The input also has a specific required [format](/docs/api-reference/batch/request-input).  Please [contact us](https://help.openai.com/) if you need to increase these storage limits.
     
     - parameter file: (form) The File object (not file name) to be uploaded.
     - parameter purpose: (form) The intended purpose of the uploaded file.  Use \\\&quot;assistants\\\&quot; for [Assistants](/docs/api-reference/assistants) and [Message](/docs/api-reference/messages) files, \\\&quot;vision\\\&quot; for Assistants image file inputs, \\\&quot;batch\\\&quot; for [Batch API](/docs/guides/batch), and \\\&quot;fine-tune\\\&quot; for [Fine-tuning](/docs/api-reference/fine-tuning).
     - returns: OpenAIFile
     */

    open func createFile(file: URL, purpose: Purpose_createFile) async throws -> OpenAIFile {
        let localVariablePath = "/files"
        
        let urlRequest = try makeRequest(
            uriPath: localVariablePath,
            httpMethod: "POST",
            request: FileRequest(file: file)
        )
        return try await send(request: urlRequest) {
            try self.jsonDecoder.decode(OpenAIFile.self, from: $0)
        }
    }
    /**
     Upload a file that can be used across various endpoints. Individual files can be up to 512 MB, and the size of all files uploaded by one organization can be up to 100 GB.  The Assistants API supports files up to 2 million tokens and of specific file types. See the [Assistants Tools guide](/docs/assistants/tools) for details.  The Fine-tuning API only supports `.jsonl` files. The input also has certain required formats for fine-tuning [chat](/docs/api-reference/fine-tuning/chat-input) or [completions](/docs/api-reference/fine-tuning/completions-input) models.  The Batch API only supports `.jsonl` files up to 100 MB in size. The input also has a specific required [format](/docs/api-reference/batch/request-input).  Please [contact us](https://help.openai.com/) if you need to increase these storage limits.
     - POST /files
     - parameter file: (form) The File object (not file name) to be uploaded.
     - parameter purpose: (form) The intended purpose of the uploaded file.  Use \\\&quot;assistants\\\&quot; for [Assistants](/docs/api-reference/assistants) and [Message](/docs/api-reference/messages) files, \\\&quot;vision\\\&quot; for Assistants image file inputs, \\\&quot;batch\\\&quot; for [Batch API](/docs/guides/batch), and \\\&quot;fine-tune\\\&quot; for [Fine-tuning](/docs/api-reference/fine-tuning).
     - returns: RequestBuilder<OpenAIFile>
     */


    /**
     Delete a file.
     
     - parameter fileId: (path) The ID of the file to use for this request.
     - returns: DeleteFileResponse
     */

    open func deleteFile(fileId: String) async throws -> DeleteFileResponse {
        var localVariablePath = "/files/{file_id}"
        let fileIdPreEscape = "\(APIHelper.mapValueToPathItem(fileId))"
        let fileIdPostEscape = fileIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{file_id}", with: fileIdPostEscape, options: .literal, range: nil)
        
        let urlRequest = try makeRequest(
            uriPath: localVariablePath,
            httpMethod: "DELETE"
        )
        return try await send(request: urlRequest) {
            try self.jsonDecoder.decode(DeleteFileResponse.self, from: $0)
        }
    }
    /**
     Delete a file.
     - DELETE /files/{file_id}
     - parameter fileId: (path) The ID of the file to use for this request.
     - returns: RequestBuilder<DeleteFileResponse>
     */


    /**
     Returns the contents of the specified file.
     
     - parameter fileId: (path) The ID of the file to use for this request.
     - returns: String
     */

    open func downloadFile(fileId: String) async throws -> String {
        var localVariablePath = "/files/{file_id}/content"
        let fileIdPreEscape = "\(APIHelper.mapValueToPathItem(fileId))"
        let fileIdPostEscape = fileIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{file_id}", with: fileIdPostEscape, options: .literal, range: nil)
        
        let urlRequest = try makeRequest(
            uriPath: localVariablePath,
            httpMethod: "GET"
        )
        return try await send(request: urlRequest) {
            try self.jsonDecoder.decode(String.self, from: $0)
        }
    }
    /**
     Returns the contents of the specified file.
     - GET /files/{file_id}/content
     - parameter fileId: (path) The ID of the file to use for this request.
     - returns: RequestBuilder<String>
     */


    /**
     Returns a list of files that belong to the user's organization.
     
     - parameter purpose: (query) Only return files with the given purpose. (optional)
     - returns: ListFilesResponse
     */

    open func listFiles(purpose: String? = nil) async throws -> ListFilesResponse {
        let localVariablePath = "/files"
        let queryParams = APIHelper.mapValuesToQueryItems([
            "purpose": (wrappedValue: purpose?.encodeToJSON(), isExplode: true),
        ])
        let urlRequest = try makeRequest(
            uriPath: localVariablePath,
            queryParams: queryParams ?? [],
            httpMethod: "GET"
        )
        return try await send(request: urlRequest) {
            try self.jsonDecoder.decode(ListFilesResponse.self, from: $0)
        }
    }
    /**
     Returns a list of files that belong to the user's organization.
     - GET /files
     - parameter purpose: (query) Only return files with the given purpose. (optional)
     - returns: RequestBuilder<ListFilesResponse>
     */


    /**
     Returns information about a specific file.
     
     - parameter fileId: (path) The ID of the file to use for this request.
     - returns: OpenAIFile
     */

    open func retrieveFile(fileId: String) async throws -> OpenAIFile {
        var localVariablePath = "/files/{file_id}"
        let fileIdPreEscape = "\(APIHelper.mapValueToPathItem(fileId))"
        let fileIdPostEscape = fileIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{file_id}", with: fileIdPostEscape, options: .literal, range: nil)
        
        let urlRequest = try makeRequest(
            uriPath: localVariablePath,
            httpMethod: "GET"
        )
        return try await send(request: urlRequest) {
            try self.jsonDecoder.decode(OpenAIFile.self, from: $0)
        }
    }
    /**
     Returns information about a specific file.
     - GET /files/{file_id}
     - parameter fileId: (path) The ID of the file to use for this request.
     - returns: RequestBuilder<OpenAIFile>
     */

}

protocol FilesAPIEndpoints {


        func createFile(file: URL, purpose: Purpose_createFile) async throws -> OpenAIFile


        func deleteFile(fileId: String) async throws -> DeleteFileResponse


        func downloadFile(fileId: String) async throws -> String


        func listFiles(purpose: String?) async throws -> ListFilesResponse


        func retrieveFile(fileId: String) async throws -> OpenAIFile
}


/**
 * enum for parameter purpose
 */
public enum Purpose_createFile: String, CaseIterable {
    case assistants = "assistants"
    case batch = "batch"
    case fineTune = "fine-tune"
    case vision = "vision"
}

public struct FileRequest: Codable {
    public let file: URL
}
