//
//  LocationManager.swift
//  SwiftChatDashboard
//
//  Created by swetha on 30/01/26.
//


import Foundation
import CoreLocation

import Foundation
import CoreLocation

@MainActor
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    @Published var userLocation: CLLocationCoordinate2D? = nil

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            print("No locations found")
            return
        }
        userLocation = location.coordinate
        print("🟢 Updated userLocation: \(location.coordinate.latitude), \(location.coordinate.longitude)")
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation()
        default:
            print("Location access denied")
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to fetch location: \(error.localizedDescription)")
    }
}
