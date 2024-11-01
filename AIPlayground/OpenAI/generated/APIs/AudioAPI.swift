//
// AudioAPI.swift
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

protocol AudioAPITransport: Sendable {
    func execute(request: Request) async throws -> (Data, URLResponse)
}

protocol AudioAPIClientMiddleware: Sendable {
    func intercept(
        _ request: Request,
        next: (Request) async throws -> (Data, URLResponse)
    ) async throws -> (Data, URLResponse)
}


open class AudioAPI: AudioAPIEndpoints, @unchecked Sendable {
    internal var transport: AudioAPITransport
    internal var middlewares: [AudioAPIClientMiddleware]
    internal var basePath: String
    internal var jsonDecoder: JSONDecoder

    init(basePath: String, transport: AudioAPITransport, middlewares: [AudioAPIClientMiddleware], jsonDecoder: JSONDecoder = JSONDecoder.default) {
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
     Generates audio from the input text.
     
     - parameter createSpeechRequest: (body)  
     - returns: URL
     */

    open func createSpeech(createSpeechRequest: CreateSpeechRequest) async throws -> URL {
        let localVariablePath = "/audio/speech"
        
        let urlRequest = try makeRequest(
            uriPath: localVariablePath,
            httpMethod: "POST",
            request: createSpeechRequest
        )
        return try await send(request: urlRequest) {
            try self.jsonDecoder.decode(URL.self, from: $0)
        }
    }
    /**
     Generates audio from the input text.
     - POST /audio/speech
     - responseHeaders: [Transfer-Encoding(String)]
     - parameter createSpeechRequest: (body)  
     - returns: RequestBuilder<URL> 
     */


    /**
     * enum for parameter timestampGranularities
     */
    public enum TimestampGranularities_createTranscription: String, CaseIterable {
        case word = "word"
        case segment = "segment"
    }

    /**
     Transcribes audio into the input language.
     
     - parameter file: (form) The audio file object (not file name) to transcribe, in one of these formats: flac, mp3, mp4, mpeg, mpga, m4a, ogg, wav, or webm.  
     - parameter model: (form)  
     - parameter language: (form) The language of the input audio. Supplying the input language in [ISO-639-1](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes) format will improve accuracy and latency.  (optional)
     - parameter prompt: (form) An optional text to guide the model&#39;s style or continue a previous audio segment. The [prompt](/docs/guides/speech-to-text/prompting) should match the audio language.  (optional)
     - parameter responseFormat: (form)  (optional)
     - parameter temperature: (form) The sampling temperature, between 0 and 1. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic. If set to 0, the model will use [log probability](https://en.wikipedia.org/wiki/Log_probability) to automatically increase the temperature until certain thresholds are hit.  (optional, default to 0)
     - parameter timestampGranularities: (form) The timestamp granularities to populate for this transcription. &#x60;response_format&#x60; must be set &#x60;verbose_json&#x60; to use timestamp granularities. Either or both of these options are supported: &#x60;word&#x60;, or &#x60;segment&#x60;. Note: There is no additional latency for segment timestamps, but generating word timestamps incurs additional latency.  (optional)
     - returns: CreateTranscription200Response
     */

    open func createTranscription(file: URL, model: CreateTranscriptionRequestModel, language: String? = nil, prompt: String? = nil, responseFormat: AudioResponseFormat? = nil, temperature: Double? = nil, timestampGranularities: [TimestampGranularities_createTranscription]? = nil) async throws -> CreateTranscription200Response {
        let localVariablePath = "/audio/transcriptions"
        
        let urlRequest = try makeRequest(
            uriPath: localVariablePath,
            httpMethod: "POST"
        )
        return try await send(request: urlRequest) {
            try self.jsonDecoder.decode(CreateTranscription200Response.self, from: $0)
        }
    }
    /**
     Transcribes audio into the input language.
     - POST /audio/transcriptions
     - parameter file: (form) The audio file object (not file name) to transcribe, in one of these formats: flac, mp3, mp4, mpeg, mpga, m4a, ogg, wav, or webm.  
     - parameter model: (form)  
     - parameter language: (form) The language of the input audio. Supplying the input language in [ISO-639-1](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes) format will improve accuracy and latency.  (optional)
     - parameter prompt: (form) An optional text to guide the model&#39;s style or continue a previous audio segment. The [prompt](/docs/guides/speech-to-text/prompting) should match the audio language.  (optional)
     - parameter responseFormat: (form)  (optional)
     - parameter temperature: (form) The sampling temperature, between 0 and 1. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic. If set to 0, the model will use [log probability](https://en.wikipedia.org/wiki/Log_probability) to automatically increase the temperature until certain thresholds are hit.  (optional, default to 0)
     - parameter timestampGranularities: (form) The timestamp granularities to populate for this transcription. &#x60;response_format&#x60; must be set &#x60;verbose_json&#x60; to use timestamp granularities. Either or both of these options are supported: &#x60;word&#x60;, or &#x60;segment&#x60;. Note: There is no additional latency for segment timestamps, but generating word timestamps incurs additional latency.  (optional)
     - returns: RequestBuilder<CreateTranscription200Response> 
     */


    /**
     Translates audio into English.
     
     - parameter file: (form) The audio file object (not file name) translate, in one of these formats: flac, mp3, mp4, mpeg, mpga, m4a, ogg, wav, or webm.  
     - parameter model: (form)  
     - parameter prompt: (form) An optional text to guide the model&#39;s style or continue a previous audio segment. The [prompt](/docs/guides/speech-to-text/prompting) should be in English.  (optional)
     - parameter responseFormat: (form)  (optional)
     - parameter temperature: (form) The sampling temperature, between 0 and 1. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic. If set to 0, the model will use [log probability](https://en.wikipedia.org/wiki/Log_probability) to automatically increase the temperature until certain thresholds are hit.  (optional, default to 0)
     - returns: CreateTranslation200Response
     */

    open func createTranslation(file: URL, model: CreateTranscriptionRequestModel, prompt: String? = nil, responseFormat: AudioResponseFormat? = nil, temperature: Double? = nil) async throws -> CreateTranslation200Response {
        let localVariablePath = "/audio/translations"
        
        let urlRequest = try makeRequest(
            uriPath: localVariablePath,
            httpMethod: "POST"
        )
        return try await send(request: urlRequest) {
            try self.jsonDecoder.decode(CreateTranslation200Response.self, from: $0)
        }
    }
    /**
     Translates audio into English.
     - POST /audio/translations
     - parameter file: (form) The audio file object (not file name) translate, in one of these formats: flac, mp3, mp4, mpeg, mpga, m4a, ogg, wav, or webm.  
     - parameter model: (form)  
     - parameter prompt: (form) An optional text to guide the model&#39;s style or continue a previous audio segment. The [prompt](/docs/guides/speech-to-text/prompting) should be in English.  (optional)
     - parameter responseFormat: (form)  (optional)
     - parameter temperature: (form) The sampling temperature, between 0 and 1. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic. If set to 0, the model will use [log probability](https://en.wikipedia.org/wiki/Log_probability) to automatically increase the temperature until certain thresholds are hit.  (optional, default to 0)
     - returns: RequestBuilder<CreateTranslation200Response> 
     */

}

protocol AudioAPIEndpoints {


        func createSpeech(createSpeechRequest: CreateSpeechRequest) async throws -> URL


        func createTranscription(file: URL, model: CreateTranscriptionRequestModel, language: String?, prompt: String?, responseFormat: AudioResponseFormat?, temperature: Double?, timestampGranularities: [TimestampGranularities_createTranscription]?) async throws -> CreateTranscription200Response


        func createTranslation(file: URL, model: CreateTranscriptionRequestModel, prompt: String?, responseFormat: AudioResponseFormat?, temperature: Double?) async throws -> CreateTranslation200Response


}

