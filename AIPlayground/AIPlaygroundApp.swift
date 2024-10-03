//
//  AIPlaygroundApp.swift
//  AIPlayground
//
//  Created by Martin Mitrevski on 1.10.24.
//

import SwiftUI
import StreamChat
import StreamChatSwiftUI

@main
struct AIPlaygroundApp: App {
    
    @State var streamChat: StreamChat?
    
    var chatClient: ChatClient = {
        var config = ChatClientConfig(apiKey: .init(apiKeyString))
        config.isLocalStorageEnabled = true
        config.applicationGroupIdentifier = applicationGroupIdentifier

        let client = ChatClient(config: config)
        return client
    }()
    
    init() {
        let utils = Utils(messageTypeResolver: CustomMessageResolver(), commandsConfig: CustomCommandsConfig())
        _streamChat = State(initialValue: StreamChat(chatClient: chatClient, utils: utils))
        chatClient.connectUser(
            userInfo: UserInfo(
                id: "anakin_skywalker",
                imageURL: URL(string: "https://vignette.wikia.nocookie.net/starwars/images/6/6f/Anakin_Skywalker_RotS.png")
            ),
            token: try! Token(rawValue: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiYW5ha2luX3NreXdhbGtlciJ9.ZwCV1qPrSAsie7-0n61JQrSEDbp6fcMgVh4V2CB0kM8")
        )
    }
        
    var body: some Scene {
        WindowGroup {
            ChatChannelListView(viewFactory: CustomViewFactory())
        }
    }
}

public let apiKeyString = "zcgvnykxsfm8"
public let applicationGroupIdentifier = "group.io.getstream.iOS.ChatDemoAppSwiftUI"
