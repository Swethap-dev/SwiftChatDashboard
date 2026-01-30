//
//  ChatDetailView.swift
//  SwiftChatDashboard
//
//  Created by swetha on 29/01/26.
//

import SwiftUI
import SwiftUI

struct ChatDetailView: View {
    let conversation: ConversationEntity
    @ObservedObject var viewModel: ChatViewModel
    @State private var newMessage: String = ""

    var body: some View {
        VStack {
            ScrollViewReader { scroll in
                List {
                    ForEach(viewModel.messagesDict[conversation.id] ?? [], id: \.id) { message in
                        ChatBubbleView(message: message)
                            .listRowSeparator(.hidden)
                    }
                }
                .listStyle(.plain)
                .onChange(of: viewModel.messagesDict[conversation.id]?.count) { _ in
                    if let last = viewModel.messagesDict[conversation.id]?.last {
                        withAnimation {
                            scroll.scrollTo(last.id, anchor: .bottom)
                        }
                    }
                }
            }

            HStack {
                TextField("Message...", text: $newMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(minHeight: 30)

                Button {
                    guard !newMessage.isEmpty else { return }
                    viewModel.sendMessage(newMessage, to: conversation)
                    newMessage = ""
                } label: {
                    Image(systemName: "paperplane.fill")
                        .font(.title2)
                        .foregroundColor(.blue)
                }
            }
            .padding()
        }
        .navigationTitle(conversation.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
