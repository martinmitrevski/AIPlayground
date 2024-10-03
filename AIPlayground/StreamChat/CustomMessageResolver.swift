//
//  CustomMessageResolver.swift
//  AIPlayground
//
//  Created by Martin Mitrevski on 2.10.24.
//

import Foundation
import SwiftUI
import StreamChat
import StreamChatSwiftUI

class CustomMessageResolver: MessageTypeResolving {
    
    func hasCustomAttachment(message: ChatMessage) -> Bool {
        message.extraData["streaming"] == true
    }
}

class CustomViewFactory: ViewFactory {
    
    @Injected(\.chatClient) var chatClient: ChatClient
    
    func makeCustomAttachmentViewType(
        for message: ChatMessage,
        isFirst: Bool,
        availableWidth: CGFloat,
        scrolledId: Binding<String?>
    ) -> some View {
        CodeTextView(content: message.text)
            .padding()
            .messageBubble(for: message, isFirst: isFirst)
    }
}
