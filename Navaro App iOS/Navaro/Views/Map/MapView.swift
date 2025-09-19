//
//  MapView.swift
//  Discover Destiny
//
//  Created by Guest User on 2025-04-12.
//

import SwiftUI
import MapKit
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()

    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 7.8731, longitude: 80.7718),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    
    @Published var userLocation: CLLocationCoordinate2D?
    @Published var nearbyLocations: [CLLocationCoordinate2D] = []
    
    private var hasGeneratedLocations = false

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            manager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        DispatchQueue.main.async {
            let coordinate = location.coordinate
            self.userLocation = coordinate
            self.region = MKCoordinateRegion(
                center: coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
            
            if !self.hasGeneratedLocations {
                self.nearbyLocations = self.generateNearbyLocations(from: coordinate, count: 10)
                self.hasGeneratedLocations = true
            }
        }
    }

    private func generateNearbyLocations(from center: CLLocationCoordinate2D, count: Int) -> [CLLocationCoordinate2D] {
        var coordinates: [CLLocationCoordinate2D] = []
        let radiusInMeters: Double = 1000

        for _ in 0..<count {
            let angle = Double.random(in: 0...2 * .pi)
            let distance = Double.random(in: 0...radiusInMeters)

            let deltaLat = (distance / 111000) * cos(angle)
            let deltaLon = (distance / (111000 * cos(center.latitude * .pi / 180))) * sin(angle)

            let newLat = center.latitude + deltaLat
            let newLon = center.longitude + deltaLon

            coordinates.append(CLLocationCoordinate2D(latitude: newLat, longitude: newLon))
        }

        return coordinates
    }
}



import SwiftUI
import MapKit
import CoreLocation

struct MapView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var selectedLocation: CLLocationCoordinate2D?
    @State private var showSheet = true

    var body: some View {
        ZStack(alignment: .top) {
            Map(coordinateRegion: $locationManager.region, showsUserLocation: true, annotationItems: locationManager.nearbyLocations) { location in
                MapAnnotation(coordinate: location) {
                    Button {
                        selectedLocation = location
                        showSheet = true
                    } label: {
                        Image(systemName: "bed.double.circle.fill")
                            .foregroundColor(Color("AppBgColor"))
                            .padding(5)
                            .background(Circle().fill(Color("LightBlue")))
                    }
                }
            }
            .ignoresSafeArea(edges: .top)

            VStack {
                MapSearchCardView()
                    .cornerRadius(12)
                    .shadow(radius: 10)
                Spacer()
            }
        }
        .sheet(item: $selectedLocation) { location in
            VStack {
                Image("h2")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 180)
                    .cornerRadius(15)
                    .padding(.top)

                HStack(alignment: .lastTextBaseline) {
                    VStack(alignment: .leading) {
                        Text("Saffron Beach Hotel")
                            .foregroundColor(Color("DarkBlue"))
                            .font(.system(size: 20, weight: .bold))
                        Text("Waaduwa • 1.4km from center")
                            .foregroundColor(Color("DarkBlue"))
                            .font(.system(size: 12))
                            .opacity(0.6)
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        HStack {
                            Text("4.9")
                                .font(.system(size: 15, weight: .bold))
                                .foregroundColor(.lightBlue)
                            Image(systemName: "star.fill")
                                .font(.system(size: 13, weight: .bold))
                                .foregroundColor(.lightBlue)
                        }
                        Text("100.99$/Day")
                            .foregroundColor(Color("DarkBlue"))
                            .font(.system(size: 14))
                            .opacity(0.6)
                    }
                }

                Button {
                    
                } label: {
                    HStack {
                        Spacer()
                        Text("Book Now")
                            .font(.system(size: 15, weight: .semibold))
                        Spacer()
                    }
                    .padding(15)
                    .foregroundColor(.white)
                }
                .background(Color("LightBlue"))
                .cornerRadius(12)

                Spacer()
            }
            .padding()
            .presentationDetents([.height(320), .medium, .large])
            .presentationDragIndicator(.visible)
        }
        .navigationTitle("Map")
    }
}



struct MapSearchCardView: View {
    @State private var searchText: String = ""
    @State private var selectedDate: String = ""
    @State private var selectedRooms: String = ""
    
    let minRadius: Double = 0
    @State private var maxRadius: Double = 300
    
    var body: some View {
        VStack(spacing: 10){
            HStack {
                HStack(alignment: .center, spacing: 15){
                    Image(systemName: "calendar.badge.clock.rtl")
                        .resizable()
                        .frame(width: 16, height: 16)
                        .opacity(0.5)
                    TextField("Dates", text: $selectedDate)
                        .foregroundColor(.black)
                }
                .padding(10)
                .background(Color("LightGray"))
                .cornerRadius(8)
                
                Spacer().frame(width: 10)
                
                HStack(alignment: .center, spacing: 15){
                    Image(systemName: "bed.double")
                        .resizable()
                        .frame(width: 16, height: 16)
                        .opacity(0.5)
                    TextField("Rooms", text: $selectedRooms)
                        .foregroundColor(.black)
                }
                .padding(10)
                .background(Color("LightGray"))
                .cornerRadius(8)
            }
            
            VStack(alignment: .leading) {
                Text("Max Radius")
                    .font(.system(size: 14, weight: .semibold))
                HStack {
                    Text("\(Int(minRadius))KM")
                    Spacer()
                    Text("\(Int(maxRadius))KM")
                }
                .font(.system(size: 12))
                .foregroundColor(.gray)
                
                Slider(value: $maxRadius, in: minRadius...100, step: 1)
                    .accentColor(Color("LightBlue"))
            }
            
            Button {
                
            } label: {
                Spacer()
                Text("SHOW HOTELS")
                    .foregroundColor(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical,15)
                    .font(.system(size: 12, weight: .semibold))
                Spacer()
            }
            .background(Color("LightBlue"))
            .cornerRadius(8)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(12)
        .padding(.horizontal)
    }
}

#Preview {
    MapView()
}


extension CLLocationCoordinate2D: Identifiable, Equatable {
    public var id: String {
        "\(latitude)-\(longitude)"
    }

    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

