//
// RunStepObjectLastError.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
/** The last error associated with this run step. Will be &#x60;null&#x60; if there are no errors. */

public struct RunStepObjectLastError: Codable, JSONEncodable, Hashable {
    public enum Code: String, Codable, CaseIterable {
        case serverError = "server_error"
        case rateLimitExceeded = "rate_limit_exceeded"
    }
    /** One of `server_error` or `rate_limit_exceeded`. */
    public var code: Code
    /** A human-readable description of the error. */
    public var message: String

    public init(code: Code, message: String) {
        self.code = code
        self.message = message
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case code
        case message
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(code, forKey: .code)
        try container.encode(message, forKey: .message)
    }
}

