//
//  ChatListView.swift
//  SwiftChatDashboard
//
//  Created by swetha on 29/01/26.
//

import SwiftUI

struct ChatListView: View {
    @StateObject var viewModel = ChatViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                // MARK: Background Gradient
                LinearGradient(
                    colors: [Color.blue.opacity(0.2), Color.cyan.opacity(0.2)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                List(viewModel.conversations) { conversation in
                    NavigationLink {
                        ChatDetailView(conversation: conversation, viewModel: viewModel)
                            .onAppear {
                                viewModel.markAsSeen(conversation: conversation)
                            }
                    } label: {
                        ChatRowView(conversation: conversation, viewModel: viewModel)
                    }
                    .listRowInsets(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
                    .listRowBackground(
                        Color.cyan.opacity(0.1)
                    )
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Chats")
        }
    }
}

struct ChatRowView: View {
    let conversation: ConversationEntity
    @ObservedObject var viewModel: ChatViewModel
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: conversation.avatarSystemName)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundColor(conversation.avatarColor)
                .background(Color.gray.opacity(0.2))
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(conversation.name)
                    .font(.headline)
                Text(viewModel.lastMessage(for: conversation))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                if let lastMessageTime = viewModel.messagesDict[conversation.id]?.last?.timestamp {
                    Text(lastMessageTime, style: .time)
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
                
                let unread = viewModel.unreadCount(for: conversation)
                if unread > 0 {
                    Text("\(unread)")
                        .font(.caption2)
                        .bold()
                        .foregroundColor(.white)
                        .padding(6)
                        .background(Color.blue)
                        .clipShape(Circle())
                }
            }
        }
    }
}


// MARK: ConversationEntity
import SwiftUI

struct ConversationEntity: Identifiable {
    let id = UUID()
    let name: String
    let avatarSystemName: String
    let avatarColor: Color
    let lastMessage: String
    let lastMessageTime: Date
    let unreadCount: Int
}
