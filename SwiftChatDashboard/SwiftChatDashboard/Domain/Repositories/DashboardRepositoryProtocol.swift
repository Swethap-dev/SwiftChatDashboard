//
//  DashboardRepositoryProtocol.swift
//  SwiftChatDashboard
//
//  Created by swetha on 30/01/26.
//


import Foundation

import Foundation
import CoreLocation

protocol DashboardRepositoryProtocol {
    func fetchWeather(for coordinate: CLLocationCoordinate2D) async -> [DashboardEntity]
}

class DashboardRepository: DashboardRepositoryProtocol {

    func fetchWeather(for coordinate: CLLocationCoordinate2D) async -> [DashboardEntity] {
        // Local simulation based on latitude
        let temp: Int
        let condition: String
        let iconName: String
        
        if coordinate.latitude > 20 {
            temp = Int.random(in: 20...30)
            condition = "Sunny"
            iconName = "sun.max"
        } else if coordinate.latitude > 10 {
            temp = Int.random(in: 25...35)
            condition = "Cloudy"
            iconName = "cloud.sun"
        } else {
            temp = Int.random(in: 28...38)
            condition = "Rainy"
            iconName = "cloud.rain"
        }
        
        let weather = DashboardEntity(
            id: UUID(),
            title: condition,
            value: "\(temp)°C",
            iconName: iconName
        )
        
        return [weather]
    }
}
