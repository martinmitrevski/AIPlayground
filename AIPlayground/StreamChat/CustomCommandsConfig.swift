//
//  CustomCommandsConfig.swift
//  AIPlayground
//
//  Created by Martin Mitrevski on 2.10.24.
//

import UIKit
import StreamChat
import StreamChatSwiftUI

class CustomCommandsConfig: CommandsConfig {
    
    public init() {}
        
    public let mentionsSymbol: String = "@"
    public let instantCommandsSymbol: String = "/"
    
    func makeCommandsHandler(with channelController: ChatChannelController) -> CommandsHandler {
        let mentionsCommand = MentionsCommandHandler(
            channelController: channelController,
            commandSymbol: mentionsSymbol,
            mentionAllAppUsers: false
        )
        let giphyCommand = GiphyCommandHandler(commandSymbol: "/giphy")
        let muteCommand = MuteCommandHandler(
            channelController: channelController,
            commandSymbol: "/mute"
        )
        let unmuteCommand = UnmuteCommandHandler(
            channelController: channelController,
            commandSymbol: "/unmute"
        )
        
        let aiCommand = AICommandHandler(
            channelController: channelController,
            commandSymbol: "/ai",
            id: "ai",
            displayInfo: .init(
                displayName: "AI bot",
                icon: UIImage(systemName: "wand.and.rays")!,
                format: "/ai [query]",
                isInstant: true
            )
        )
        
        // Add or remove commands here, or change the order.
        let instantCommands = InstantCommandsHandler(
            commands: [aiCommand, giphyCommand, muteCommand, unmuteCommand]
        )
        return CommandsHandler(commands: [mentionsCommand, instantCommands])
    }
}
