//
//  SampleIntegration.swift
//  AIPlayground
//
//  Created by Martin Mitrevski on 1.10.24.
//

import SwiftUI

struct SampleIntegration: View {
    
    @State var streamChatAI = StreamChatAI(
        apiKey: "YOUR_API_KEY"
    )
    
    @State var response = ""
    @State var query = ""
    @State var generatingResponse = false
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollViewReader { reader in
                ScrollView {
                    CodeTextView(content: response)
                        .padding()
                        .background(response.isEmpty ? nil : Color(uiColor: .init(rgb: 0xecebeb)))
                        .cornerRadius(16)
                    Color.clear
                        .id("bottom")
                        .onChange(of: response) { oldValue, newValue in
                            reader.scrollTo("bottom", anchor: .bottom)
                        }
                }
            }

            HStack {
                TextField("Send a message", text: $query)
                    .opacity(generatingResponse ? 0 : 1)
                    .overlay(
                        generatingResponse ? HStack(spacing: 8) {
                            Text("Generating response")
                            ProgressView()
                        } : nil
                    )
                Button(action: {
                    let messages: [[String: String]] = [
                        ["role": "system", "content": "You are a helpful assistant."],
                        ["role": "user", "content": query]
                    ]
                    query = ""
                    response = ""
                    generatingResponse = true
                    streamChatAI.sendMessageStreaming(messages: messages) { chunk in
                        withAnimation {
                            self.response += chunk
                        }
                    } onFinish: {
                        generatingResponse = false
                    }
                }, label: {
                    Image(systemName: "paperplane.fill")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 22)
                        .rotationEffect(Angle(degrees: 45))
                })
                .disabled(query.isEmpty)
            }
        }
        .padding()
    }
}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(
            red: r / 255,
            green: g / 255,
            blue: b / 255,
            alpha: 1
        )
    }

    convenience init(red: Int, green: Int, blue: Int) {
        self.init(
            r: CGFloat(red),
            g: CGFloat(green),
            b: CGFloat(blue)
        )
    }

    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xff,
            green: (rgb >> 8) & 0xff,
            blue: rgb & 0xff
        )
    }
}
