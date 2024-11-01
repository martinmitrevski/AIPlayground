//
//  AIStreamingHelper.swift
//  AIPlayground
//
//  Created by Martin Mitrevski on 31.10.24.
//

import Foundation
import StreamChat

public class AIStreamingHelper: ObservableObject, EventsControllerDelegate {
    
    @Published var isGenerating = false
    
    private var channelController: ChatChannelController?
    
    private let chatClient: ChatClient
    
    private var messageId: MessageId?
    
    private let streamChatAI: StreamChatAI
    
    private let eventsController: EventsController
    
    var stream: AsyncStream<StreamingChunk>?
    
    var text = ""
    var textToSend = ""
    var chunkCounter = 0
    var runId: String?
    
    private let chunkLimit = 15
    
    init(chatClient: ChatClient, streamChatAI: StreamChatAI) {
        self.chatClient = chatClient
        self.streamChatAI = streamChatAI
        self.eventsController = chatClient.eventsController()
        eventsController.delegate = self
    }
    
    func createAssistant(name: String, model: String) async throws {
        try await streamChatAI.createAssistant(name: name, model: model)
    }
    
    func createThread(for channelId: ChannelId) async throws {
        createChannelControllerIfNeeded(for: channelId)
        
        guard let channelController else { return }
        
        var imageAttachments = [ChatMessageImageAttachment]()
        let messages: [CreateMessageRequest] = channelController.messages.prefix(30).reversed().compactMap { message in
            if !message.imageAttachments.isEmpty {
                imageAttachments.append(contentsOf: message.imageAttachments)
            }
            if message.text.isEmpty {
                return nil
            } else {
                return CreateMessageRequest(role: .user, content: .typeString(message.text))
            }
        }
        try await streamChatAI.createThread(with: messages)
        
        //TODO: handle this properly
        /*
        if !imageAttachments.isEmpty {
            let url = imageAttachments[0].imageURL
            Task {
                do {
                    let messageRequest = CreateMessageRequest(
                        role: .user,
                        content: .typeArrayOfContentPartsInner([.typeMessageContentImageUrlObject(.init(type: .imageUrl, imageUrl: .init(url: "https://ichef.bbci.co.uk/images/ic/976xn/p0cyrmlg.png")))])
                    )
                    let result = try await streamChatAI.createMessage(createMessageRequest: messageRequest)
                } catch {
                    print("========= \(error)")
                }
            }
        }
         */
    }
    
    func startStreaming(message: String, channelId: ChannelId) async throws {
        if isGenerating {
            return
        }
        
        createChannelControllerIfNeeded(for: channelId)
        
        do {
            guard let channelController else { return }
            isGenerating = true
            channelController.ephemeralMessageEditor.updateMessage(
                text: "",
                extraData: ["streaming": true, "state": "Analyzing"]
            )
            self.stream = try await self.streamChatAI.createRun(
                content: message,
                additionalMessages: [CreateMessageRequest(role: .user, content: .typeString(message))],
                stream: true
            )
            
            for await chunk in self.stream! {
                if !self.isGenerating {
                    return
                }
                if chunk.event == "thread.message.delta" {
                    self.text += chunk.text ?? ""
                    channelController.ephemeralMessageEditor.updateMessage(
                        text: self.text,
                        extraData: ["streaming": true, "current": true]
                    )
                    if channelController.channel?.watcherCount ?? 0 > 1 {
                        self.chunkCounter += 1
                        self.textToSend += chunk.text ?? ""
                        if self.chunkCounter == chunkLimit {
                            self.chunkCounter = 0
                            let text = self.textToSend
                            self.textToSend = ""
                            channelController
                                .eventsController()
                                .sendEvent(StreamingChunkEvent(
                                    runId: chunk.runId,
                                    threadId: chunk.threadId,
                                    text: text)
                                )
                        }
                    }
                } else if chunk.event == "thread.run.step.created" {
                    channelController.ephemeralMessageEditor.updateMessage(
                        text: "",
                        extraData: ["streaming": true, "state": "Thinking"]
                    )
                } else if chunk.event == "thread.run.created" {
                    let runId = chunk.runId
                    self.runId = runId
                    channelController
                        .eventsController()
                        .sendEvent(StreamingStartedEvent(messageId: "messageId", runId: runId, threadId: chunk.threadId))
                    channelController.ephemeralMessageEditor.updateMessage(
                        text: "",
                        extraData: ["streaming": true]
                    )
                } else if chunk.event == "thread.run.completed" {
                    channelController
                        .eventsController()
                        .sendEvent(
                            StreamingEndedEvent(runId: chunk.runId, threadId: chunk.threadId)
                        )
                    channelController.ephemeralMessageEditor.publish()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        self.isGenerating = false
                    })
                }
            }

        } catch {
            print("====== \(error)")
            self.isGenerating = false
        }
    }
    
    func cancelStreaming() async throws {
        if let runId = self.runId {
            channelController?
                .eventsController()
                .sendEvent(
                    StreamingCancelledEvent(runId: runId)
                )
            try await self.streamChatAI.cancelRun(runId: runId)
        }
        channelController?.ephemeralMessageEditor.delete()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.isGenerating = false
        })
    }
    
    public func eventsController(_ eventsController: EventsController, didReceiveEvent event: Event) {
        guard let channelEvent = event as? UnknownChannelEvent, let channelController else {
            return
        }
        
        if self.isGenerating { return }
        
        if channelEvent.payload(ofType: StreamingStartedEvent.self) != nil {
            text = ""
            channelController.ephemeralMessageEditor.updateMessage(text: "", extraData: ["streaming": true])
            return
        }

        if let streamingChunkEvent = channelEvent.payload(ofType: StreamingChunkEvent.self) {
            text += streamingChunkEvent.text
            channelController.ephemeralMessageEditor.updateMessage(text: text, extraData: ["streaming": true])
        }
        
        if channelEvent.payload(ofType: StreamingEndedEvent.self) != nil ||
            channelEvent.payload(ofType: StreamingCancelledEvent.self) != nil {
            text = ""
            channelController.ephemeralMessageEditor.delete()
        }
    }
    
    func setChannelControllerIfNeeded(_ channelController: ChatChannelController) {
        if self.channelController == nil || self.channelController?.cid != channelController.cid {
            self.channelController = channelController
        }
    }
    
    func clearChannelController() {
        channelController = nil
    }
    
    private func createChannelControllerIfNeeded(for channelId: ChannelId) {
        if channelController == nil || channelController?.cid != channelId {
            channelController = chatClient.channelController(for: channelId)
        }
    }
}
