//
// AuditLogsAPI.swift
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

protocol AuditLogsAPITransport: Sendable {
    func execute(request: Request) async throws -> (Data, URLResponse)
}

protocol AuditLogsAPIClientMiddleware: Sendable {
    func intercept(
        _ request: Request,
        next: (Request) async throws -> (Data, URLResponse)
    ) async throws -> (Data, URLResponse)
}


open class AuditLogsAPI: AuditLogsAPIEndpoints, @unchecked Sendable {
    internal var transport: AuditLogsAPITransport
    internal var middlewares: [AuditLogsAPIClientMiddleware]
    internal var basePath: String
    internal var jsonDecoder: JSONDecoder

    init(basePath: String, transport: AuditLogsAPITransport, middlewares: [AuditLogsAPIClientMiddleware], jsonDecoder: JSONDecoder = JSONDecoder.default) {
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
     List user actions and configuration changes within this organization.
     
     - parameter effectiveAt: (query) Return only events whose &#x60;effective_at&#x60; (Unix seconds) is in this range. (optional)
     - parameter projectIds: (query) Return only events for these projects. (optional)
     - parameter eventTypes: (query) Return only events with a &#x60;type&#x60; in one of these values. For example, &#x60;project.created&#x60;. For all options, see the documentation for the [audit log object](/docs/api-reference/audit-logs/object). (optional)
     - parameter actorIds: (query) Return only events performed by these actors. Can be a user ID, a service account ID, or an api key tracking ID. (optional)
     - parameter actorEmails: (query) Return only events performed by users with these emails. (optional)
     - parameter resourceIds: (query) Return only events performed on these targets. For example, a project ID updated. (optional)
     - parameter limit: (query) A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 20.  (optional, default to 20)
     - parameter after: (query) A cursor for use in pagination. &#x60;after&#x60; is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with obj_foo, your subsequent call can include after&#x3D;obj_foo in order to fetch the next page of the list.  (optional)
     - parameter before: (query) A cursor for use in pagination. &#x60;before&#x60; is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with obj_foo, your subsequent call can include before&#x3D;obj_foo in order to fetch the previous page of the list.  (optional)
     - returns: ListAuditLogsResponse
     */

    open func listAuditLogs(effectiveAt: ListAuditLogsEffectiveAtParameter? = nil, projectIds: [String]? = nil, eventTypes: [AuditLogEventType]? = nil, actorIds: [String]? = nil, actorEmails: [String]? = nil, resourceIds: [String]? = nil, limit: Int? = nil, after: String? = nil, before: String? = nil) async throws -> ListAuditLogsResponse {
        let localVariablePath = "/organization/audit_logs"
        let queryParams = APIHelper.mapValuesToQueryItems([
            "effective_at": (wrappedValue: effectiveAt?.encodeToJSON(), isExplode: true),
            "project_ids[]": (wrappedValue: projectIds?.encodeToJSON(), isExplode: true),
            "event_types[]": (wrappedValue: eventTypes?.encodeToJSON(), isExplode: true),
            "actor_ids[]": (wrappedValue: actorIds?.encodeToJSON(), isExplode: true),
            "actor_emails[]": (wrappedValue: actorEmails?.encodeToJSON(), isExplode: true),
            "resource_ids[]": (wrappedValue: resourceIds?.encodeToJSON(), isExplode: true),
            "limit": (wrappedValue: limit?.encodeToJSON(), isExplode: true),
            "after": (wrappedValue: after?.encodeToJSON(), isExplode: true),
            "before": (wrappedValue: before?.encodeToJSON(), isExplode: true),
        ])
        let urlRequest = try makeRequest(
            uriPath: localVariablePath,
            queryParams: queryParams ?? [],
            httpMethod: "GET"
        )
        return try await send(request: urlRequest) {
            try self.jsonDecoder.decode(ListAuditLogsResponse.self, from: $0)
        }
    }
    /**
     List user actions and configuration changes within this organization.
     - GET /organization/audit_logs
     - parameter effectiveAt: (query) Return only events whose &#x60;effective_at&#x60; (Unix seconds) is in this range. (optional)
     - parameter projectIds: (query) Return only events for these projects. (optional)
     - parameter eventTypes: (query) Return only events with a &#x60;type&#x60; in one of these values. For example, &#x60;project.created&#x60;. For all options, see the documentation for the [audit log object](/docs/api-reference/audit-logs/object). (optional)
     - parameter actorIds: (query) Return only events performed by these actors. Can be a user ID, a service account ID, or an api key tracking ID. (optional)
     - parameter actorEmails: (query) Return only events performed by users with these emails. (optional)
     - parameter resourceIds: (query) Return only events performed on these targets. For example, a project ID updated. (optional)
     - parameter limit: (query) A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 20.  (optional, default to 20)
     - parameter after: (query) A cursor for use in pagination. &#x60;after&#x60; is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with obj_foo, your subsequent call can include after&#x3D;obj_foo in order to fetch the next page of the list.  (optional)
     - parameter before: (query) A cursor for use in pagination. &#x60;before&#x60; is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with obj_foo, your subsequent call can include before&#x3D;obj_foo in order to fetch the previous page of the list.  (optional)
     - returns: RequestBuilder<ListAuditLogsResponse> 
     */

}

protocol AuditLogsAPIEndpoints {


        func listAuditLogs(effectiveAt: ListAuditLogsEffectiveAtParameter?, projectIds: [String]?, eventTypes: [AuditLogEventType]?, actorIds: [String]?, actorEmails: [String]?, resourceIds: [String]?, limit: Int?, after: String?, before: String?) async throws -> ListAuditLogsResponse


}
