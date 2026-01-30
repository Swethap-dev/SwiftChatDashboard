//
//  DashboardChartData.swift
//  SwiftChatDashboard
//
//  Created by swetha on 30/01/26.
//


import Foundation

struct DashboardChartData: Identifiable {
    let id = UUID()
    let category: String
    let value: Double
}
