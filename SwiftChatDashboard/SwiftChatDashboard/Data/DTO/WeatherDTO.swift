//
//  WeatherDTO.swift
//  SwiftChatDashboard
//
//  Created by swetha on 30/01/26.
//


import Foundation
import CoreLocation

struct WeatherDTO: Decodable {
    let main: Main
    let weather: [Weather]

    struct Main: Decodable {
        let temp: Double
    }

    struct Weather: Decodable {
        let main: String
        let icon: String
    }
}

