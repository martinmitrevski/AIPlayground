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
        
    private var text: String = ""
    
    private let channelController: ChatChannelController
    private var messageId: MessageId?
    private var messageController: ChatMessageController?
        
    var stream: AsyncStream<StreamingChunk>?
    
    var textToSend = ""
    var chunkCounter = 0
    
    private let chunkLimit = 15
    
    private let aiStreamingHelper: AIStreamingHelper
        
    init(
        channelController: ChatChannelController,
        aiStreamingHelper: AIStreamingHelper,
        commandSymbol: String,
        id: String,
        displayInfo: CommandDisplayInfo? = nil,
        mentionSymbol: String = "@"
    ) {
        self.channelController = channelController
        self.aiStreamingHelper = aiStreamingHelper
        super.init(
            channelController: channelController,
            commandSymbol: commandSymbol,
            id: id,
            displayInfo: displayInfo,
            mentionSymbol: mentionSymbol
        )
        
        Task {
            if let cider = channelController.cid {
                try await aiStreamingHelper.createThread(for: cider)
            }
        }
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
            self?.sendMessageEphemeral(composerCommand: composerCommand)
        })
    }    
    
    private func sendMessageEphemeral(composerCommand: ComposerCommand) {
        let content = composerCommand.typingSuggestion.text
                
        Task {
            if let channelId = channelController.cid {
                try await aiStreamingHelper.startStreaming(message: content, channelId: channelId)
            }
        }
    }
}
