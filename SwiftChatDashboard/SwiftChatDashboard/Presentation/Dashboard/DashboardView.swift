//
//  DashboardView.swift
//  SwiftChatDashboard
//
//  Created by swetha on 29/01/26.
//

import SwiftUI
import MapKit
import Charts

// Make CLLocationCoordinate2D equatable for SwiftUI onChange
extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

struct DashboardView: View {
    @ObservedObject var viewModel: DashboardViewModel
    @ObservedObject var chatViewModel: ChatViewModel // pass the real chat VM

    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 8.5241, longitude: 76.9366),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @State private var appear = false

    // For adding a new location
    @State private var newLat: Double = 0.0
    @State private var newLon: Double = 0.0

    var body: some View {
        
        ZStack {
            // MARK: Background Gradient
            LinearGradient(
                colors: [Color.blue.opacity(0.2), Color.cyan.opacity(0.2)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    
                    // MARK: Weather Cards
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(viewModel.weather) { weather in
                                DashboardCardView(title: weather.title,
                                                  value: weather.value,
                                                  iconName: weather.iconName ?? "")
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // MARK: Map Section
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Locations")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        Map(coordinateRegion: $region,
                            interactionModes: .all,
                            showsUserLocation: true,
                            annotationItems: viewModel.locations) { location in
                            MapMarker(coordinate: location.coordinate, tint: .red)
                        }
                            .frame(height: 280)
                            .cornerRadius(20)
                            .padding(.horizontal)
                            .scaleEffect(appear ? 1 : 0.9)
                            .opacity(appear ? 1 : 0)
                            .onAppear {
                                withAnimation(.spring(response: 0.5, dampingFraction: 0.6)) {
                                    appear = true
                                }
                            }
                        
                        // Add location
                        HStack {
                            TextField("Latitude", value: $newLat, format: .number)
                                .textFieldStyle(.roundedBorder)
                            TextField("Longitude", value: $newLon, format: .number)
                                .textFieldStyle(.roundedBorder)
                            Button("Add") {
                                viewModel.addLocation(latitude: newLat, longitude: newLon)
                                // Update chart immediately
                                viewModel.generateChartData(
                                    
                                )
                            }
                            .buttonStyle(.borderedProminent)
                        }
                        .padding()
                    }
                    
                    // MARK: Charts Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Statistics")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        Chart(viewModel.chartData) { data in
                            BarMark(
                                x: .value("Category", data.category),
                                y: .value("Value", data.value)
                            )
                            .foregroundStyle(LinearGradient(colors: [.blue, .cyan],
                                                            startPoint: .bottom,
                                                            endPoint: .top))
                            .annotation(position: .top) {
                                Text("\(Int(data.value))")
                                    .font(.caption2)
                                    .foregroundColor(.primary)
                            }
                        }
                        .frame(height: 220)
                        .padding()
                        .background(.ultraThickMaterial)
                        .cornerRadius(20)
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
        }
        .navigationTitle("Dashboard")
        .refreshable {
            await viewModel.loadData()
        }
        .task {
            await viewModel.loadData()
        }
    }
}
