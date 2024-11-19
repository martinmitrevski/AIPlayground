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

    @StateObject var channelListViewModel: ChatChannelListViewModel
    
    var streamChatAI: StreamChatAI = {
        StreamChatAI(apiKey: "your_api_key")
    }()
        
    let aiStreamingHelper: AIStreamingHelper
    
    var chatClient: ChatClient = {
        var config = ChatClientConfig(apiKey: .init(apiKeyString))
        config.isLocalStorageEnabled = true
        config.applicationGroupIdentifier = applicationGroupIdentifier

        let client = ChatClient(config: config)
        return client
    }()
    
    init() {
        _channelListViewModel = StateObject(wrappedValue: ViewModelsFactory.makeChannelListViewModel())
        aiStreamingHelper = AIStreamingHelper(chatClient: chatClient, streamChatAI: streamChatAI)
        let utils = Utils(
            messageTypeResolver: CustomMessageResolver(),
            commandsConfig: CustomCommandsConfig(aiStreamingHelper: aiStreamingHelper),
            messageListConfig: .init(messageDisplayOptions: .init(spacerWidth: { _ in return 60 }))
        )
        _streamChat = State(initialValue: StreamChat(chatClient: chatClient, utils: utils))
        let credentials = UserCredentials.anakin
        chatClient.connectUser(
            userInfo: credentials.user,
            token: try! Token(rawValue: credentials.token)
        )
    }
        
    var body: some Scene {
        WindowGroup {
            ChatChannelListView(
                viewFactory: CustomViewFactory(
                    streamChatAI: streamChatAI,
                    aiStreamingHelper: aiStreamingHelper
                ),
                viewModel: channelListViewModel
            )
                .onAppear {
                    Task {
                        try await streamChatAI.createAssistant(name: "test1", model: "gpt-4o")
                    }
                }
                .onChange(of: channelListViewModel.selectedChannel) { oldValue, newValue in
                    if let newValue {
//                        aiStreamingHelper.setChannelControllerIfNeeded(
//                            chatClient.channelController(for: newValue.channel.cid)
//                        )
//                        Task {
//                            try await StreamAIChatService.shared.setupAgent(channelId: newValue.channel.cid.id)
//                        }
                    } else {
                        aiStreamingHelper.clearChannelController()
//                        Task {
//                            if let oldValue = oldValue {
//                                try await StreamAIChatService.shared.stopAgent(channelId: oldValue.channel.cid.id)
//                            }
//                        }
                    }
                    TypingIndicatorHandler.shared.channelId = newValue?.channel.cid
                }
        }
    }
}

public let apiKeyString = "zcgvnykxsfm8"
public let applicationGroupIdentifier = "group.io.getstream.iOS.ChatDemoAppSwiftUI"

struct UserCredentials {
    let user: UserInfo
    let token: String
}

extension UserCredentials {
    static let anakin = UserCredentials(
        user: UserInfo(
            id: "anakin_skywalker",
            imageURL: URL(string: "https://vignette.wikia.nocookie.net/starwars/images/6/6f/Anakin_Skywalker_RotS.png")
        ),
        token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiYW5ha2luX3NreXdhbGtlciJ9.ZwCV1qPrSAsie7-0n61JQrSEDbp6fcMgVh4V2CB0kM8"
    )
    
    static let r2d2 = UserCredentials(
        user: UserInfo(
            id: "r2-d2",
            imageURL: URL(string: "https://vignette.wikia.nocookie.net/starwars/images/e/eb/ArtooTFA2-Fathead.png")
        ),
        token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoicjItZDIifQ.zoi2pzALI8a2sQFLhOIxnZawHooj_PqJF0jToqOpNP4"
    )
}
