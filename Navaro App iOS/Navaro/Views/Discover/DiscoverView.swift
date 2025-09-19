//
//  DiscoverView.swift
//  Navaro
//
//  Created by Guest User on 2025-09-09

import SwiftUI
import CoreLocation

let topSearchHotels: [Hotel] = [
    Hotel(
        name: "Saffron Beach Hotel",
        location: "Wadduwa",
        distanceFromCenter: "1.4km",
        price: 100.50,
        rating: 5,
        boardType: "Half board",
        imageName: "h1",
        coordinates: CLLocationCoordinate2D(latitude: 6.6850, longitude: 79.9303)
    ),
    Hotel(
        name: "Jetwing Blue",
        location: "Negombo",
        distanceFromCenter: "2.0km",
        price: 125.00,
        rating: 4,
        boardType: "Full board",
        imageName: "h2",
        coordinates: CLLocationCoordinate2D(latitude: 7.2090, longitude: 79.8380)
    ),
    Hotel(
        name: "Amari Galle",
        location: "Galle",
        distanceFromCenter: "1.8km",
        price: 145.75,
        rating: 5,
        boardType: "Bed & Breakfast",
        imageName: "h3",
        coordinates: CLLocationCoordinate2D(latitude: 6.0367, longitude: 80.2170)
    ),
    Hotel(
        name: "Cinnamon Grand",
        location: "Colombo",
        distanceFromCenter: "1.1km",
        price: 180.00,
        rating: 5,
        boardType: "Half board",
        imageName: "h1",
        coordinates: CLLocationCoordinate2D(latitude: 6.9180, longitude: 79.8560)
    ),
    Hotel(
        name: "Heritance Kandalama",
        location: "Dambulla",
        distanceFromCenter: "3.0km",
        price: 140.99,
        rating: 4,
        boardType: "Full board",
        imageName: "h2",
        coordinates: CLLocationCoordinate2D(latitude: 7.6742, longitude: 80.6750)
    ),
    Hotel(
        name: "Taj Bentota Resort",
        location: "Bentota",
        distanceFromCenter: "1.5km",
        price: 160.00,
        rating: 5,
        boardType: "All inclusive",
        imageName: "h3",
        coordinates: CLLocationCoordinate2D(latitude: 6.4224, longitude: 79.9975)
    ),
    Hotel(
        name: "The Grand Hotel",
        location: "Nuwara Eliya",
        distanceFromCenter: "0.5km",
        price: 130.00,
        rating: 4,
        boardType: "Bed & Breakfast",
        imageName: "h1",
        coordinates: CLLocationCoordinate2D(latitude: 6.9667, longitude: 80.7833)
    ),
    Hotel(
        name: "Anantaya Resort",
        location: "Chilaw",
        distanceFromCenter: "2.2km",
        price: 110.00,
        rating: 4,
        boardType: "Half board",
        imageName: "h2",
        coordinates: CLLocationCoordinate2D(latitude: 7.5833, longitude: 79.8000)
    ),
    Hotel(
        name: "Araliya Green Hills",
        location: "Nuwara Eliya",
        distanceFromCenter: "0.7km",
        price: 150.00,
        rating: 5,
        boardType: "Full board",
        imageName: "h3",
        coordinates: CLLocationCoordinate2D(latitude: 6.9497, longitude: 80.7893)
    ),
    Hotel(
        name: "Trinco Blu by Cinnamon",
        location: "Trincomalee",
        distanceFromCenter: "3.5km",
        price: 120.00,
        rating: 4,
        boardType: "Bed & Breakfast",
        imageName: "h1",
        coordinates: CLLocationCoordinate2D(latitude: 8.5860, longitude: 81.2345)
    )
]

struct DiscoverView: View {
    @State private var searchText = ""
    @State private var selectedHotel: Hotel?
    @State private var maxPrice: Double = 300

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    SearchHeaderView()
                    SearchTopSearchesView(
                        searchText: searchText,
                        selectedHotel: $selectedHotel,
                        maxPrice: $maxPrice
                    )
                }
            }
            .navigationDestination(item: $selectedHotel) { hotel in
                BookingView(hotel: hotel)
            }
        }
    }
}

struct SearchHeaderView : View {
    var body: some View {
        HStack{
            VStack(alignment: .leading, content: {
                Text("Hey !")
                    .font(.system(size: 16, weight: .semibold))
                    .opacity(0.6)
                Text("Let's find the best hotel for you")
                    .foregroundColor(Color("DarkBlue"))
                    .font(.system(size: 30, weight: .heavy))
            })
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top,15)
        .padding(.bottom,-10)
    }
}


struct SearchCardView: View {
    @Binding var searchText: String
    @Binding var maxPrice: Double

    @State private var selectedDate: String = ""
    @State private var selectedRooms: String = ""
    let minPrice: Double = 50

    var body: some View {
        VStack(spacing: 10){
            HStack(alignment: .center, spacing: 15){
                Image("SearchIcon")
                    .resizable()
                    .frame(width: 16, height: 16)
                    .opacity(0.5)
                
                TextField("Enter your destination", text: $searchText)
                    .foregroundColor(.black)
                
                Spacer()
            }
            .padding(10)
            .background(Color("LightGray"))
            .cornerRadius(8)
            
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
                Text("Max Price")
                    .font(.system(size: 14, weight: .semibold))
                HStack {
                    Text("From $\(Int(minPrice))")
                    Spacer()
                    Text("To $\(Int(maxPrice))")
                }
                .font(.system(size: 12))
                .foregroundColor(.gray)

                Slider(value: $maxPrice, in: minPrice...500, step: 10)
                    .accentColor(Color("LightBlue"))
            }

            // ... existing search button
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(12)
    }
}


struct SearchTopSearchesView: View {
    @State var searchText: String
    @Binding var selectedHotel: Hotel?
    @Binding var maxPrice: Double

    private var filteredHotels: [Hotel] {
        topSearchHotels.filter {
            (searchText.isEmpty ||
             $0.name.lowercased().contains(searchText.lowercased()) ||
             $0.location.lowercased().contains(searchText.lowercased()))
            && $0.price <= maxPrice
        }
    }

    var body: some View {
        VStack(spacing: 15) {
            SearchCardView(searchText: $searchText, maxPrice: $maxPrice)
            ForEach(filteredHotels) { hotel in
                TopSearchCardView(hotel: hotel) {
                    selectedHotel = hotel
                }
            }
        }
        .padding(.horizontal)
    }
}




struct TopSearchCardView: View {
    let hotel: Hotel
    var onTap: () -> Void
    var body: some View {
        ZStack {
            Image(hotel.imageName)
                .resizable()
                .scaledToFill()
            
            VStack {
                HStack {
                    HStack {
                        Image(systemName: "car.fill")
                            .foregroundColor(Color("DarkBlue"))
                            .font(.system(size: 12))
                        Text("\(hotel.distanceFromCenter) / 2 min")
                            .foregroundColor(Color("DarkBlue"))
                            .font(.system(size: 12, weight: .bold))
                            .opacity(0.8)
                    }
                    .padding(6)
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                    
                    Spacer()
                    
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(Color("DarkBlue"))
                            .font(.system(size: 12))
                        Text(String(format: "%.1f", hotel.rating))
                            .foregroundColor(.black)
                            .font(.system(size: 12, weight: .bold))
                            .opacity(0.8)
                    }
                    .padding(6)
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                }
                .padding(10)
                
                Spacer()
                
                HStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Text(hotel.name)
                            Text("• \(hotel.distanceFromCenter) from center")
                            Spacer()
                            Text("\(String(format: "%.2f", hotel.price))$")
                        }
                        .foregroundColor(.white)
                        .font(.system(size: 12, weight: .semibold))
                        
                        HStack {
                            Text(hotel.location)
                                .opacity(0.7)
                            Spacer()
                            Text(hotel.boardType)
                        }
                        .foregroundColor(.white)
                        .font(.system(size: 8))
                    }
                    
                    Spacer()
                }
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                .background(Color("LightBlue"))
            }
        }
        
        .cornerRadius(12)
        .onTapGesture {
            onTap()
        }
    }
}





#Preview {
    DiscoverView()
}
