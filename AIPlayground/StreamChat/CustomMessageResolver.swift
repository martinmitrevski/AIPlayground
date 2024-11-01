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

class CustomMessageResolver: MessageTypeResolving {
    
    func hasCustomAttachment(message: ChatMessage) -> Bool {
        message.extraData["streaming"] == true
    }
}

class CustomViewFactory: ViewFactory {
    
    @Injected(\.chatClient) var chatClient: ChatClient
    
    let streamChatAI: StreamChatAI
    let aiStreamingHelper: AIStreamingHelper
    
    init(streamChatAI: StreamChatAI, aiStreamingHelper: AIStreamingHelper) {
        self.streamChatAI = streamChatAI
        self.aiStreamingHelper = aiStreamingHelper
    }
    
    @ViewBuilder
    func makeCustomAttachmentViewType(
        for message: ChatMessage,
        isFirst: Bool,
        availableWidth: CGFloat,
        scrolledId: Binding<String?>
    ) -> some View {
        let state = message.extraData["state"]?.stringValue
        if state == "Analyzing" {
            Text("Analyzing...")
                .padding()
                .messageBubble(for: message, isFirst: isFirst)
        } else if state == "Thinking" {
            Text("Thinking...")
                .padding()
                .messageBubble(for: message, isFirst: isFirst)
        } else {
            let isCurrent = message.extraData["current"]?.boolValue ?? true
            if isCurrent {
                StreamAITextView(content: message.text)
                    .padding()
                    .messageBubble(for: message, isFirst: isFirst)
            } else {
                StreamAITextViewOther(content: message.text)
                    .padding()
                    .messageBubble(for: message, isFirst: isFirst)
            }
        }
    }
    
    func makeTrailingComposerView(
        enabled: Bool,
        cooldownDuration: Int,
        onTap: @escaping () -> Void
    ) -> some View {
        CustomTrailingComposerView(
            aiStreamingHelper: aiStreamingHelper,
            onTap: onTap
        )
    }
}

public struct CustomTrailingComposerView: View {
    
    @Injected(\.utils) private var utils
        
    @EnvironmentObject var viewModel: MessageComposerViewModel
    
    var onTap: () -> Void
    
    @ObservedObject var aiStreamingHelper: AIStreamingHelper
    
    public init(
        aiStreamingHelper: AIStreamingHelper,
        onTap: @escaping () -> Void
    ) {
        self.onTap = onTap
        self.aiStreamingHelper = aiStreamingHelper
    }
    
    public var body: some View {
        Group {
            if aiStreamingHelper.isGenerating {
                Button {
                    Task {
                        try await aiStreamingHelper.cancelStreaming()
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
