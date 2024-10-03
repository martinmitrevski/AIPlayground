//
//  AICommandHandler.swift
//  AIPlayground
//
//  Created by Martin Mitrevski on 2.10.24.
//

import Foundation
import StreamChat
import StreamChatSwiftUI

class AICommandHandler: TwoStepMentionCommand {
    
    @Injected(\.chatClient) var chatClient
    
    let streamChatAI = StreamChatAI(
        apiKey: "YOUR_API_KEY"
    )
    
    private var text: String = ""
    
    private let channelController: ChatChannelController
    private var messageId: MessageId?
    private var messageController: ChatMessageController?
    
    override init(channelController: ChatChannelController, commandSymbol: String, id: String, displayInfo: CommandDisplayInfo? = nil, mentionSymbol: String = "@") {
        self.channelController = channelController
        super.init(
            channelController: channelController,
            commandSymbol: commandSymbol,
            id: id,
            displayInfo: displayInfo,
            mentionSymbol: mentionSymbol
        )
    }
    
    override func canBeExecuted(composerCommand: ComposerCommand) -> Bool {
        return true
    }
    
    override var replacesMessageSent: Bool {
        false
    }
    
    override func executeOnMessageSent(
        composerCommand: ComposerCommand,
        completion: @escaping ((any Error)?) -> Void
    ) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: { [weak self] in
            self?.sendMessage(composerCommand: composerCommand)
        })
    }
    
    private func sendMessage(composerCommand: ComposerCommand) {
        let content = composerCommand.typingSuggestion.text
        let messages: [[String: String]] = [
            ["role": "system", "content": "You are a helpful assistant."],
            ["role": "user", "content": content]
        ]
        
        text = ""
        channelController.createNewMessage(text: "", extraData: ["streaming": true]) { [weak self] result in
            guard let self, let cid = channelController.cid, let messageId = try? result.get() else { return }
            self.messageId = messageId
            self.messageController = chatClient.messageController(
                cid: cid,
                messageId: messageId
            )
            streamChatAI.sendMessageStreaming(
                messages: messages
            ) { [weak self] chunk in
                guard let self else { return }
                self.text += chunk
                self.messageController?.editMessage(text: self.text, extraData: ["streaming": true])
            } onFinish: {
                print("==== finished")
            }
        }
    }
}
