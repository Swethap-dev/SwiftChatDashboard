//
//  UserEntity.swift
//  SwiftChatDashboard
//
//  Created by swetha on 29/01/26.
//

import Foundation

struct DashboardEntity: Identifiable {
    let id: UUID
    let title: String
    let value: String
    let iconName: String?
}

extension DashboardEntity {
    init(weatherDTO: WeatherDTO) {
        self.id = UUID()
        self.title = weatherDTO.weather.first?.main ?? "Weather"
        
        // Convert Kelvin to Celsius
        let tempC = Int(weatherDTO.main.temp - 273.15)
        self.value = "\(tempC)°C"
        
        // Map weather icon
        self.iconName = DashboardEntity.weatherIconMapping(weatherDTO.weather.first?.icon ?? "01d")
    }

    private static func weatherIconMapping(_ icon: String) -> String {
        switch icon {
        case "01d": return "sun.max"
        case "01n": return "moon"
        case "02d", "02n": return "cloud.sun"
        case "03d", "03n": return "cloud"
        case "04d", "04n": return "smoke"
        case "09d", "09n": return "cloud.rain"
        case "10d", "10n": return "cloud.sun.rain"
        case "11d", "11n": return "cloud.bolt"
        case "13d", "13n": return "snow"
        case "50d", "50n": return "cloud.fog"
        default: return "cloud"
        }
    }
}
