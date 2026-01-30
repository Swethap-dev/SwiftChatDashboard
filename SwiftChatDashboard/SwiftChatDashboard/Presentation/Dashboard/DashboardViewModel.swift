//
//  DashboardViewModel.swift
//  SwiftChatDashboard
//
//  Created by swetha on 30/01/26.
//

import Foundation
import MapKit

import Foundation
import MapKit

struct DashboardLocation: Identifiable, Equatable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    
    static func == (lhs: DashboardLocation, rhs: DashboardLocation) -> Bool {
        lhs.coordinate.latitude == rhs.coordinate.latitude &&
        lhs.coordinate.longitude == rhs.coordinate.longitude
    }
}

@MainActor
class DashboardViewModel: ObservableObject {
    private let repository: DashboardRepositoryProtocol
    private let chatViewModel: ChatViewModel

    @Published var weather: [DashboardEntity] = []
    @Published var locations: [DashboardLocation] = []
    @Published var userCoordinate: CLLocationCoordinate2D?
    @Published var chartData: [DashboardChartData] = []

    private var locationManager = LocationManager()

    init(repository: DashboardRepositoryProtocol, chatViewModel: ChatViewModel) {
        self.repository = repository
        self.chatViewModel = chatViewModel

        // Observe location updates
        Task { @MainActor in
            for await coord in locationManager.$userLocation.values {
                self.userCoordinate = coord
                if let coord = coord {
                    self.weather = self.simulateWeather(for: coord)
                } else {
                    let defaultCoord = CLLocationCoordinate2D(latitude: 8.5241, longitude: 76.9366)
                    self.weather = self.simulateWeather(for: defaultCoord)
                }
            }
        }

        // Default Kerala location
        self.locations = [
            DashboardLocation(coordinate: CLLocationCoordinate2D(latitude: 8.5241, longitude: 76.9366))
        ]

        // Generate chart **once at init** using ChatViewModel
        generateChartData()
    }


    /// Add new location
    func addLocation(latitude: Double, longitude: Double) {
        let newLocation = DashboardLocation(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        if !locations.contains(newLocation) {
            locations.append(newLocation)
            generateChartData() // update chart
        }
    }

    /// Load data (simulate weather + optional demo location)
    func loadData() async {
        // Update weather
        if let coord = userCoordinate {
            self.weather = simulateWeather(for: coord)
        }

        // Add demo location if not exists
        let klLocation = DashboardLocation(coordinate: CLLocationCoordinate2D(latitude: 9.9312, longitude: 76.2673))
        if !locations.contains(klLocation) {
            locations.append(klLocation)
        }

        // Update chart
        generateChartData()
    }

    /// Simulate weather locally based on latitude
    private func simulateWeather(for coordinate: CLLocationCoordinate2D) -> [DashboardEntity] {
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

        return [DashboardEntity(id: UUID(), title: condition, value: "\(temp)°C", iconName: iconName)]
    }

    /// Generate chart data: unread messages, images, locations
    func generateChartData() {
        let unreadMessages = chatViewModel.conversations.reduce(0) { $0 + $1.unreadCount } ?? 0
       
        let locationCount = locations.count

        chartData = [
            DashboardChartData(category: "Unread Messages", value: Double(unreadMessages)),
            DashboardChartData(category: "Images Sent", value: Double(9)),
            DashboardChartData(category: "Locations", value: Double(locationCount))
        ]
    }
}
