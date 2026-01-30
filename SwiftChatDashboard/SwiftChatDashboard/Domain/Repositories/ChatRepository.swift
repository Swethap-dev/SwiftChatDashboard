//
//  ChatRepository.swift
//  SwiftChatDashboard
//
//  Created by swetha on 29/01/26.
//

import SwiftUI

protocol ChatRepositoryProtocol {
    func fetchMessages() async -> [MessageEntity]
    func sendMessage(_ message: MessageEntity)
}

class ChatRepository: ChatRepositoryProtocol {
    @Published private(set) var messages: [MessageEntity] = []

    func fetchMessages() async -> [MessageEntity] {
        // Preloaded mock messages
        messages = [
            MessageEntity(text: "Hello!", sender: "Alice", timestamp: Date()),
            MessageEntity(text: "Hi there!", sender: "Bob", timestamp: Date())
        ]
        return messages
    }

    func sendMessage(_ message: MessageEntity) {
        messages.append(message)
    }
}
