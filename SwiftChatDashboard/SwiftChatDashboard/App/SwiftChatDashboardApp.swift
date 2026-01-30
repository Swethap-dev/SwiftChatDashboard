//
//  SwiftChatDashboardApp.swift
//  SwiftChatDashboard
//
//  Created by swetha on 29/01/26.
//

import SwiftUI

@main
struct SwiftChatDashboardApp: App {

    let diContainer = DIContainer()

    var body: some Scene {
        WindowGroup {
            // Root View
            AppCoordinatorView()
                .environmentObject(diContainer.chatViewModel)
                .environmentObject(diContainer.dashboardViewModel)
        }
    }
}
