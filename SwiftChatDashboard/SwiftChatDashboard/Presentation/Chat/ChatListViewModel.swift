//
//  ChatListViewModel.swift
//  SwiftChatDashboard
//
//  Created by swetha on 30/01/26.
//

import Foundation
import SwiftUI

import SwiftUI
import NaturalLanguage

@MainActor
class ChatViewModel: ObservableObject {

    @Published var conversations: [ConversationEntity] = []
    @Published var messagesDict: [UUID: [MessageEntity]] = [:]
    @Published var lastSeenDict: [UUID: Date] = [:] // Track last seen message per conversation

    init() {
        loadConversations()
    }

    func loadConversations() {
        // Static contacts
        conversations = [
            ConversationEntity(name: "Alice", avatarSystemName: "person.crop.circle.fill", avatarColor: .blue, lastMessage: "Hey!", lastMessageTime: Date(), unreadCount: 2),
            ConversationEntity(name: "Bob", avatarSystemName: "person.circle.fill", avatarColor: .green, lastMessage: "See you tomorrow", lastMessageTime: Date().addingTimeInterval(-3600), unreadCount: 0),
            ConversationEntity(name: "Charlie", avatarSystemName: "person.2.circle.fill", avatarColor: .orange, lastMessage: "Got it 👍", lastMessageTime: Date().addingTimeInterval(-7200), unreadCount: 1),
        ]

        // Setup initial message
        for convo in conversations {
            messagesDict[convo.id] = [
                MessageEntity(text: convo.lastMessage, sender: convo.name, timestamp: convo.lastMessageTime)
            ]
        }
    }

    func sendMessage(_ text: String, to conversation: ConversationEntity) {
        // Add user message
        let userMessage = MessageEntity(text: text, sender: "Me", timestamp: Date())
        messagesDict[conversation.id, default: []].append(userMessage)

        // Generate bot reply asynchronously
        generateReply(for: text, conversation: conversation)
    }

    private func generateReply(for text: String, conversation: ConversationEntity) {
        Task {
            try? await Task.sleep(nanoseconds: 1_000_000_000) // 1s delay to simulate typing

            let reply = botReply(for: text)
            let botMessage = MessageEntity(text: reply, sender: conversation.name, timestamp: Date())

            messagesDict[conversation.id, default: []].append(botMessage)
        }
    }
    // Compute unread count for a conversation
    func unreadCount(for conversation: ConversationEntity) -> Int {
        guard let messages = messagesDict[conversation.id] else { return 0 }
        let lastSeen = lastSeenDict[conversation.id] ?? Date.distantPast
        return messages.filter { $0.sender != "Me" && $0.timestamp > lastSeen }.count
    }

    // Get last message text
    func lastMessage(for conversation: ConversationEntity) -> String {
        messagesDict[conversation.id]?.last?.text ?? ""
    }

    // Update last seen when opening chat
    func markAsSeen(conversation: ConversationEntity) {
        if let lastMessage = messagesDict[conversation.id]?.last {
            lastSeenDict[conversation.id] = lastMessage.timestamp
        }
    }

    private func botReply(for text: String) -> String {
        // Simple keyword-based reply
        let lowercased = text.lowercased()
        if lowercased.contains("hi") || lowercased.contains("hello") {
            return "Hello! How are you?"
        } else if lowercased.contains("how") && lowercased.contains("you") {
            return "I'm just code, but I'm doing great! 😄"
        } else if lowercased.contains("bye") || lowercased.contains("see you") {
            return "Goodbye! Talk soon!"
        } else if lowercased.contains("thanks") || lowercased.contains("thank") {
            return "You're welcome! 😊"
        } else {
            // Random generic reply
            let replies = ["Interesting!", "Tell me more.", "I see.", "Can you explain?", "Hmm..."]
            return replies.randomElement() ?? "Okay!"
        }
    }
}
