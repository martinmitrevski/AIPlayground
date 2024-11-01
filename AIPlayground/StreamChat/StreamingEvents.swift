//
//  StreamingEvents.swift
//  AIPlayground
//
//  Created by Martin Mitrevski on 1.11.24.
//

import Foundation
import StreamChat

struct StreamingStartedEvent: CustomEventPayload {
    static var eventType: EventType = "streaming_started"
    
    let messageId: String
    let runId: String
    let threadId: String
}

struct StreamingChunkEvent: CustomEventPayload {
    static var eventType: EventType = "chunk_received"
    
    let runId: String
    let threadId: String
    let text: String
}

struct StreamingEndedEvent: CustomEventPayload {
    static var eventType: EventType = "streaming_ended"
    
    let runId: String
    let threadId: String
}

struct StreamingCancelledEvent: CustomEventPayload {
    static var eventType: EventType = "streaming_cancelled"
    
    let runId: String
}
