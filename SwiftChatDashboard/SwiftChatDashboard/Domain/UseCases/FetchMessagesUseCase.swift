//
//  FetchMessagesUseCase.swift
//  SwiftChatDashboard
//
//  Created by swetha on 29/01/26.
//

import Foundation

protocol FetchMessagesUseCase {
    func execute() async throws -> [MessageEntity]
}

final class FetchMessagesUseCaseImpl: FetchMessagesUseCase {

    private let repository: ChatRepository

    init(repository: ChatRepository) {
        self.repository = repository
    }

    func execute() async throws -> [MessageEntity] {
        try await repository.fetchMessages()
    }
}
