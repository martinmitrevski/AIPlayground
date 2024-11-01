//
// CompletionsAPI.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case head = "HEAD"
    case patch = "PATCH"
    case options = "OPTIONS"
    case trace = "TRACE"
    case connect = "CONNECT"

    init(stringValue: String) {
        guard let method = HTTPMethod(rawValue: stringValue.uppercased()) else {
            self = .get
            return
        }
        self = method
    }
}

internal struct Request {
    var url: URL
    var method: HTTPMethod
    var body: Data? = nil
    var queryParams: [URLQueryItem] = []
    var headers: [String: String] = [:]

    func urlRequest() throws -> URLRequest {
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        var existingQueryItems = urlComponents.queryItems ?? []
        existingQueryItems.append(contentsOf: queryParams)
        urlComponents.queryItems = existingQueryItems
        var urlRequest = URLRequest(url: urlComponents.url!)
        headers.forEach { (k, v) in
            urlRequest.setValue(v, forHTTPHeaderField: k)
        }
        urlRequest.httpMethod = method.rawValue
        urlRequest.httpBody = body
        return urlRequest
    }
}

protocol CompletionsAPITransport: Sendable {
    func execute(request: Request) async throws -> (Data, URLResponse)
}

protocol CompletionsAPIClientMiddleware: Sendable {
    func intercept(
        _ request: Request,
        next: (Request) async throws -> (Data, URLResponse)
    ) async throws -> (Data, URLResponse)
}


open class CompletionsAPI: CompletionsAPIEndpoints, @unchecked Sendable {
    internal var transport: CompletionsAPITransport
    internal var middlewares: [CompletionsAPIClientMiddleware]
    internal var basePath: String
    internal var jsonDecoder: JSONDecoder

    init(basePath: String, transport: CompletionsAPITransport, middlewares: [CompletionsAPIClientMiddleware], jsonDecoder: JSONDecoder = JSONDecoder.default) {
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
     Creates a completion for the provided prompt and parameters.
     
     - parameter createCompletionRequest: (body)  
     - returns: CreateCompletionResponse
     */

    open func createCompletion(createCompletionRequest: CreateCompletionRequest) async throws -> CreateCompletionResponse {
        let localVariablePath = "/completions"
        
        let urlRequest = try makeRequest(
            uriPath: localVariablePath,
            httpMethod: "POST",
            request: createCompletionRequest
        )
        return try await send(request: urlRequest) {
            try self.jsonDecoder.decode(CreateCompletionResponse.self, from: $0)
        }
    }
    /**
     Creates a completion for the provided prompt and parameters.
     - POST /completions
     - parameter createCompletionRequest: (body)  
     - returns: RequestBuilder<CreateCompletionResponse> 
     */

}

protocol CompletionsAPIEndpoints {


        func createCompletion(createCompletionRequest: CreateCompletionRequest) async throws -> CreateCompletionResponse


}

