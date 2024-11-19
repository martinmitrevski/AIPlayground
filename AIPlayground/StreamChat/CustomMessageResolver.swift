//
//  CustomMessageResolver.swift
//  AIPlayground
//
//  Created by Martin Mitrevski on 2.10.24.
//

import Foundation
import SwiftUI
import StreamChat
import StreamChatAI
import StreamChatSwiftUI

enum StreamChatAIConstants {
    static let aiGenerated = "ai_generated"
    static let isStreaming = "streaming"
    static let streamingState = "streaming_state"
    static let currentUserGenerating = "current-user-generating"
}

class CustomMessageResolver: MessageTypeResolving {
    
    func hasCustomAttachment(message: ChatMessage) -> Bool {
        message.extraData[StreamChatAIConstants.aiGenerated] == true
    }
}

class CustomViewFactory: ViewFactory {
    
    @Injected(\.chatClient) var chatClient: ChatClient
    
    let aiInidcatorHandler = TypingIndicatorHandler.shared
    
    let streamChatAI: StreamChatAI
    let aiStreamingHelper: AIStreamingHelper
        
    init(streamChatAI: StreamChatAI, aiStreamingHelper: AIStreamingHelper) {
        self.streamChatAI = streamChatAI
        self.aiStreamingHelper = aiStreamingHelper
    }
    
    func makeMessageListContainerModifier() -> some ViewModifier {
        CustomMessageListContainerModifier(aiInidcatorHandler: aiInidcatorHandler)
    }
    
    @ViewBuilder
    func makeCustomAttachmentViewType(
        for message: ChatMessage,
        isFirst: Bool,
        availableWidth: CGFloat,
        scrolledId: Binding<String?>
    ) -> some View {
        StreamAITextView(
            content: message.text,
            isGenerating: message.extraData["generating"]?.boolValue == true
        )
        .padding()
        .messageBubble(for: message, isFirst: isFirst)
    }
    
    func makeTrailingComposerView(
        enabled: Bool,
        cooldownDuration: Int,
        onTap: @escaping () -> Void
    ) -> some View {
        CustomTrailingComposerView(
            onTap: onTap
        )
    }
}

public struct CustomTrailingComposerView: View {
    
    @Injected(\.utils) private var utils
        
    @EnvironmentObject var viewModel: MessageComposerViewModel
    
    var onTap: () -> Void
    
    @ObservedObject var typingIndicatorHandler = TypingIndicatorHandler.shared
        
    public init(
        onTap: @escaping () -> Void
    ) {
        self.onTap = onTap
    }
    
    public var body: some View {
        Group {
            if typingIndicatorHandler.generating {
                Button {
                    Task {
                        viewModel.channelController
                            .eventsController()
                            .sendEvent(
                                StreamingCancelledEvent()
                            )
                    }
                } label: {
                    Image(systemName: "stop.circle.fill")
                }
            } else {
                SendMessageButton(
                    enabled: viewModel.sendButtonEnabled,
                    onTap: onTap
                )
            }
        }
        .padding(.bottom, 8)
    }
}

struct CustomMessageListContainerModifier: ViewModifier {
    
    @ObservedObject var aiInidcatorHandler: TypingIndicatorHandler
    
    func body(content: Content) -> some View {
        content.overlay {
            VStack {
                HStack {
                    Spacer()
                    if !aiInidcatorHandler.aiBotPresent {
                        Button {
                            Task {
                                if let channelId = aiInidcatorHandler.channelId {
                                    try await StreamAIChatService.shared.setupAgent(channelId: channelId.id)
                                }
                            }
                        } label: {
                            AIIndicatorButton(title: "Start AI")
                        }
                    } else {
                        Button {
                            Task {
                                if let channelId = aiInidcatorHandler.channelId {
                                    try await StreamAIChatService.shared.stopAgent(channelId: channelId.id)
                                }
                            }
                        } label: {
                            AIIndicatorButton(title: "Stop AI")
                        }

                    }
                }
                Spacer()
                if !aiInidcatorHandler.state.isEmpty && !aiInidcatorHandler.generating {
                    HStack {
                        SmoothThinkingAnimationView(text: aiInidcatorHandler.state)
                        Spacer()
                    }
                    .padding()
                    .frame(height: 80)
                    .background(Color(UIColor.secondarySystemBackground))
                }
            }
        }
    }
}

struct AIIndicatorButton: View {
    
    let title: String
        
    var body: some View {
        HStack {
            Text(title)
                .bold()
            Image(systemName: "wand.and.stars.inverse")
        }
        .padding(.all, 8)
        .padding(.horizontal, 4)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
        .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
        .padding()
    }
}

struct SmoothThinkingAnimationView: View {
    @State private var animate = false
    
    var text: String

    var body: some View {
        HStack(spacing: 5) {
            Text(text)
            ForEach(0..<3) { i in
                Circle()
                    .frame(width: 8, height: 8)
                    .scaleEffect(animate ? 1 : 0.5)
                    .opacity(animate ? 1 : 0.3)
                    .animation(
                        Animation.easeInOut(duration: 0.8)
                            .repeatForever()
                            .delay(Double(i) * 0.2),
                        value: animate
                    )
            }
        }
        .onAppear {
            animate = true
        }
    }
}

class TypingIndicatorHandler: ObservableObject, EventsControllerDelegate, ChatChannelMemberListControllerDelegate {
    
    @Injected(\.chatClient) var chatClient: ChatClient
    
    private var eventsController: EventsController!
    
    @Published var state: String = ""
    
    private let aiBotId = "ai-bot"
    
    @Published var aiBotPresent = false
    
    @Published var generating = false
    
    var channelId: ChannelId? {
        didSet {
            if let channelId = channelId {
                memberListController = chatClient.memberListController(query: .init(cid: channelId))
                memberListController?.delegate = self
                memberListController?.synchronize { [weak self] _ in
                    guard let self else { return }
                    self.aiBotPresent = self.isAiBotPresent
                }
            }
        }
    }
    
    var isAiBotPresent: Bool {
        let aiAgent = memberListController?
            .members
            .first(where: { $0.id == self.aiBotId })
        return aiAgent?.isOnline == true
    }
    
    var memberListController: ChatChannelMemberListController?
    
    static let shared = TypingIndicatorHandler()
    
    private init() {
        eventsController = chatClient.eventsController()
        eventsController.delegate = self
    }
    
    func eventsController(_ controller: EventsController, didReceiveEvent event: any Event) {
        guard let channelEvent = event as? UnknownChannelEvent else {
            return
        }
        
        if let aiInidcatorEvent = channelEvent.payload(ofType: AIIndicatorEvent.self) {
            if aiInidcatorEvent.state == "Clear" {
                state = ""
                generating = false
            } else {
                state = aiInidcatorEvent.state
                if aiInidcatorEvent.state == "Generating" {
                    generating = true
                }
            }
        }
    }
    
    func memberListController(
        _ controller: ChatChannelMemberListController,
        didChangeMembers changes: [ListChange<ChatChannelMember>]
    ) {
        self.aiBotPresent = isAiBotPresent
    }
}
