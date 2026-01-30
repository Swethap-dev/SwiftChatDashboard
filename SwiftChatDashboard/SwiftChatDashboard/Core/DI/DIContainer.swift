//
//  DIContainer.swift
//  SwiftChatDashboard
//
//  Created by swetha on 29/01/26.
//

import SwiftUI

@MainActor
final class DIContainer {

    let chatRepository: ChatRepositoryProtocol
    let dashboardRepository: DashboardRepositoryProtocol

    let chatViewModel: ChatViewModel
    let dashboardViewModel: DashboardViewModel

    init() {
        self.chatRepository = ChatRepository()
        self.dashboardRepository = DashboardRepository()

        self.chatViewModel = ChatViewModel()
        self.dashboardViewModel = DashboardViewModel(repository: dashboardRepository, chatViewModel: chatViewModel)
    }
}
