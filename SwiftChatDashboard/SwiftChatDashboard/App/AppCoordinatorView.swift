//
//  AppCoordinatorView.swift
//  SwiftChatDashboard
//
//  Created by swetha on 30/01/26.
//


import SwiftUI

struct AppCoordinatorView: View {
    @EnvironmentObject var chatVM: ChatViewModel
    @EnvironmentObject var dashboardVM: DashboardViewModel

    var body: some View {
        TabView {
            DashboardView(viewModel: dashboardVM, chatViewModel: chatVM)
                .tabItem {
                    Label("Dashboard", systemImage: "chart.bar")
                }

            ImageTabView()
                .tabItem {
                    Label("Images", systemImage: "photo")
                }

            ChatListView(viewModel: chatVM)
                .tabItem {
                    Label("Chat", systemImage: "message")
                }
        }
    }
}
