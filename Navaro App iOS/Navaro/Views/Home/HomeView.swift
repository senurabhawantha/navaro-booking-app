//
//  HomeView.swift
//  Navaro
//
//  Created by Guest User on 2025-09-09
//

import SwiftUI
import FirebaseAuth
import CoreLocation
import UserNotifications


let nearbyHotels: [Hotel] = [
    Hotel(
        name: "Ocean Bliss Resort",
        location: "Mirissa",
        distanceFromCenter: "0.8km",
        price: 89.99,
        rating: 4,
        boardType: "Bed & Breakfast",
        imageName: "sug_image",
        coordinates: CLLocationCoordinate2D(latitude: 5.9485, longitude: 80.4597)
    ),
    Hotel(
        name: "Palm Paradise Retreat",
        location: "Unawatuna",
        distanceFromCenter: "1.2km",
        price: 112.50,
        rating: 5,
        boardType: "Half board",
        imageName: "h3",
        coordinates: CLLocationCoordinate2D(latitude: 6.0094, longitude: 80.2506)
    ),
    Hotel(
        name: "Lagoon View Hotel",
        location: "Bentota",
        distanceFromCenter: "1.0km",
        price: 98.00,
        rating: 4,
        boardType: "Full board",
        imageName: "h1",
        coordinates: CLLocationCoordinate2D(latitude: 6.4182, longitude: 80.0038)
    ),
    Hotel(
        name: "Blue Horizon Inn",
        location: "Hikkaduwa",
        distanceFromCenter: "0.6km",
        price: 105.75,
        rating: 5,
        boardType: "All inclusive",
        imageName: "sug_image",
        coordinates: CLLocationCoordinate2D(latitude: 6.1399, longitude: 80.1000)
    ),
    Hotel(
        name: "Golden Sand Escape",
        location: "Kalutara",
        distanceFromCenter: "1.9km",
        price: 97.30,
        rating: 3,
        boardType: "Bed & Breakfast",
        imageName: "h3",
        coordinates: CLLocationCoordinate2D(latitude: 6.5836, longitude: 79.9598)
    ),
    Hotel(
        name: "Jungle Breeze Hotel",
        location: "Ella",
        distanceFromCenter: "0.4km",
        price: 85.00,
        rating: 4,
        boardType: "Half board",
        imageName: "h1",
        coordinates: CLLocationCoordinate2D(latitude: 6.8667, longitude: 81.0500)
    ),
    Hotel(
        name: "River Edge Resort",
        location: "Kitulgala",
        distanceFromCenter: "2.3km",
        price: 92.45,
        rating: 4,
        boardType: "Full board",
        imageName: "sug_image",
        coordinates: CLLocationCoordinate2D(latitude: 6.9900, longitude: 80.4200)
    ),
    Hotel(
        name: "Sunset Cliff Hotel",
        location: "Weligama",
        distanceFromCenter: "1.1km",
        price: 109.90,
        rating: 5,
        boardType: "All inclusive",
        imageName: "h3",
        coordinates: CLLocationCoordinate2D(latitude: 5.9750, longitude: 80.4250)
    ),
    Hotel(
        name: "Serenity Bay Resort",
        location: "Nilaveli",
        distanceFromCenter: "2.0km",
        price: 120.00,
        rating: 5,
        boardType: "Full board",
        imageName: "h1",
        coordinates: CLLocationCoordinate2D(latitude: 8.7250, longitude: 81.2000)
    ),
    Hotel(
        name: "Tea Leaf Hideaway",
        location: "Haputale",
        distanceFromCenter: "1.6km",
        price: 95.20,
        rating: 4,
        boardType: "Bed & Breakfast",
        imageName: "sug_image",
        coordinates: CLLocationCoordinate2D(latitude: 6.7700, longitude: 80.9580)
    )
]



let sriLankanHotels: [Hotel] = [
    Hotel(
        name: "Saffron Beach Hotel",
        location: "Wadduwa",
        distanceFromCenter: "1.4km",
        price: 100.50,
        rating: 5,
        boardType: "Half board",
        imageName: "sug_image",
        coordinates: CLLocationCoordinate2D(latitude: 6.6850, longitude: 79.9303)
    ),
    Hotel(
        name: "Jetwing Blue",
        location: "Negombo",
        distanceFromCenter: "2.0km",
        price: 125.00,
        rating: 4,
        boardType: "Full board",
        imageName: "h3",
        coordinates: CLLocationCoordinate2D(latitude: 7.2090, longitude: 79.8380)
    ),
    Hotel(
        name: "Amari Galle",
        location: "Galle",
        distanceFromCenter: "1.8km",
        price: 145.75,
        rating: 5,
        boardType: "Bed & Breakfast",
        imageName: "h1",
        coordinates: CLLocationCoordinate2D(latitude: 6.0367, longitude: 80.2170)
    ),
    Hotel(
        name: "Cinnamon Grand",
        location: "Colombo",
        distanceFromCenter: "1.1km",
        price: 180.00,
        rating: 5,
        boardType: "Half board",
        imageName: "sug_image",
        coordinates: CLLocationCoordinate2D(latitude: 6.9180, longitude: 79.8560)
    ),
    Hotel(
        name: "Heritance Kandalama",
        location: "Dambulla",
        distanceFromCenter: "3.0km",
        price: 140.99,
        rating: 4,
        boardType: "Full board",
        imageName: "h3",
        coordinates: CLLocationCoordinate2D(latitude: 7.6742, longitude: 80.6750)
    ),
    Hotel(
        name: "Taj Bentota Resort",
        location: "Bentota",
        distanceFromCenter: "1.5km",
        price: 160.00,
        rating: 5,
        boardType: "All inclusive",
        imageName: "h1",
        coordinates: CLLocationCoordinate2D(latitude: 6.4224, longitude: 79.9975)
    ),
    Hotel(
        name: "The Grand Hotel",
        location: "Nuwara Eliya",
        distanceFromCenter: "0.5km",
        price: 130.00,
        rating: 4,
        boardType: "Bed & Breakfast",
        imageName: "sug_image",
        coordinates: CLLocationCoordinate2D(latitude: 6.9667, longitude: 80.7833)
    ),
    Hotel(
        name: "Anantaya Resort",
        location: "Chilaw",
        distanceFromCenter: "2.2km",
        price: 110.00,
        rating: 4,
        boardType: "Half board",
        imageName: "h3",
        coordinates: CLLocationCoordinate2D(latitude: 7.5833, longitude: 79.8000)
    ),
    Hotel(
        name: "Araliya Green Hills",
        location: "Nuwara Eliya",
        distanceFromCenter: "0.7km",
        price: 150.00,
        rating: 5,
        boardType: "Full board",
        imageName: "h1",
        coordinates: CLLocationCoordinate2D(latitude: 6.9497, longitude: 80.7893)
    ),
    Hotel(
        name: "Trinco Blu by Cinnamon",
        location: "Trincomalee",
        distanceFromCenter: "3.5km",
        price: 120.00,
        rating: 4,
        boardType: "Bed & Breakfast",
        imageName: "sug_image",
        coordinates: CLLocationCoordinate2D(latitude: 8.5860, longitude: 81.2345)
    )
]


struct HomeView: View {
    var body: some View {
        ZStack(alignment: .top) {
            Color("AppBgColor").ignoresSafeArea()
            ScrollView(showsIndicators: false){
                VStack(spacing: 0) {
                    HomeHeaderView()
                    HomeCoupenView()
                    SuggestionView()
                    HomeHotelsNearByView()
                    Spacer()
                }
            }
        }.onAppear {
            
        }
    }
}

struct HomeSearchView: View {
    
    let viewWidth = UIScreen.main.bounds.width - 120
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                        .foregroundColor(.black.opacity(0.6))
                    
                    Text("Search Hotels")
                        .foregroundColor(.black.opacity(0.7))
                        .font(.system(size: 15, weight: .regular))
                    
                    Spacer()
                }
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .frame(width: viewWidth)
            .background(
                Color.white.opacity(0.50)
                    .blur(radius: 10)
            )
            .background(.ultraThinMaterial)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.white.opacity(0.25), lineWidth: 1)
            )
            .shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 2)
            .padding(.top, 20)
        }
    }
}



struct SuggestionView: View {
    var body: some View {
        VStack {
            HStack(alignment: .bottom){
                Text("You may like")
                    .foregroundColor(Color("DarkBlue"))
                    .font(.system(size: 16, weight: .semibold))
                
                Spacer()
                
                Text("See all")
                    .foregroundColor(.blue)
                    .font(.system(size: 13, weight: .semibold))
            }
            .padding(15)
            ScrollView(.horizontal ,showsIndicators: false) {
                HStack{
                    ForEach(sriLankanHotels) { hotel in
                        HomeSuggestionCardView(hotel: hotel)
                            .padding(.bottom, 10)
                    }
                    Spacer()
                    
                }
            }
            .padding(.horizontal)
            .padding(.top,-15)
            
        }
        
        
        
        
        .background(Color("AppBgColor"))
        
    }
}

#Preview {
    HomeView()
    
}


struct HomeHeaderView : View {
    @State private var userName: String = ""
    
    var body: some View{
        ZStack(alignment: .top) {
            GeometryReader { geometry in
                GeometryReader { geometry in
                    Image("HeaderImage")
                        .resizable()
                        .scaledToFill()
                        .blur(radius: 3, opaque: true)
                }
            }
            .padding(.top, -(UIApplication.shared.windows.first?.safeAreaInsets.top ?? 44))
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    VStack(alignment: .leading, spacing: -3) {
                        Text("Hey \(userName)!")
                            .foregroundColor(.white)
                            .font(.system(size: 25, weight: .bold))
                            .shadow(color: .black, radius: 15)
                        
                        Text("Let's start exploring 👋")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .bold))
                            .shadow(color: .black, radius: 15)
                    }
                    
                    Spacer()
                    
                    Image("UserImage")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .scaledToFit()
                        .cornerRadius(25)
                }
                
                HStack {
                    Spacer()
                    HomeSearchView()
                    Spacer()
                }
            }
            
            .padding(.vertical, 10)
            .padding(.horizontal, 25)
            
        }
        .onAppear(perform: {
            self.userName = AuthViewModel().userModel?.displayName ?? ""
        })
        .frame(height: UIScreen.main.bounds.width * 0.5)
    }
}

struct HomeSuggestionCardView: View {
    
    let hotel: Hotel
    
    @State var cardWidth = UIScreen.main.bounds.width / 2.7
    @State var cardHeight = UIScreen.main.bounds.width / 2.7 * 1.3
    
    var body: some View {
        NavigationLink(destination: BookingView(hotel:hotel)){
                ZStack {
                    Image(hotel.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: cardWidth, height: cardHeight)
                    
                    
                    VStack(){
                        HStack {
                            Spacer()
                            HStack{
                                Image(systemName: "star.fill")
                                    .foregroundColor(Color("DarkBlue"))
                                    .font(.system(size: 12))
                                    .padding(.trailing , -3)
                                Text("\(hotel.rating)")
                                    .foregroundColor(.black)
                                    .font(.system(size: 12 , weight: .bold))
                                    .opacity(0.8)
                            }
                            .padding(.horizontal,5)
                            .padding(.vertical,2)
                            .background(
                                Color.white.opacity(0.4)
                                    .blur(radius: 0.5)
                            )
                            .background(.ultraThinMaterial)
                            .cornerRadius(10)
                            .padding(10)
                        }
                        
                        Spacer()
                        
                        HStack{
                            VStack(alignment: .leading){
                                Text(hotel.name)
                                    .foregroundColor(.white)
                                    .font(.system(size: 12, weight: .semibold))
                                Text(hotel.location)
                                    .foregroundColor(.white)
                                    .font(.system(size: 8, weight: .regular))
                                    .opacity(0.7)
                            }
                            
                            Spacer()
                        }
                        .padding(.vertical,5)
                        .padding(.horizontal,10)
                        .background(Color("LightBlue"))
                    }
                }
                .background(Color("AppBg"))
                .frame(width: cardWidth, height: cardHeight)
                .cornerRadius(12)
            }
        }
    
}



struct HomeCoupenView : View {
    var body: some View{
        VStack{
            HStack{
                VStack(alignment: .leading){
                    HStack{
                        VStack(alignment: .leading){
                            Text("👀 25% Flat Off 🔥")
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                            Text("Your next booking • before May 1st")
                                .font(.system(size: 13))
                        }
                        Spacer()
                        VStack(alignment: .trailing){
                            Text("BBB12343")
                                .foregroundColor(Color("DarkBlue"))
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                            Text("Your code")
                                .font(.system(size: 12))
                                .opacity(0.5)
                            
                        }
                        .padding(.trailing,10)
                        
                    }
                    Spacer()
                    HStack{
                        Text("• Tearms and condions are applied")
                            .font(.system(size: 10))
                            .opacity(0.7)
                        Spacer()
                        HStack{
                            Text("Redeem now")
                                .font(.system(size: 10))
                                .foregroundColor(.white)
                            
                        }
                        .padding(5)
                        .padding(.horizontal,10)
                        .background(Color("LightBlue"))
                        .cornerRadius(50)
                        .padding(.trailing,10)
                        .padding(.top,-5)
                        
                    }
                    
                    
                    
                }
                .padding(.vertical,15)
                
                Spacer()
            }
            .padding(.leading,20)
            .frame(maxWidth: .infinity)
            .frame(height: 80)
            .background(Color.white)
            .cornerRadius(10)
            
        }
        .padding(.bottom,10)
        .padding(.top,-25)
        .padding(.horizontal,30)
        
        
        
    }
}


struct HomeHotelsNearByView: View {
    var body: some View {
        VStack {
            HStack(alignment: .bottom){
                Text("Top Nearby Hotels")
                    .foregroundColor(Color("DarkBlue"))
                    .font(.system(size: 16, weight: .semibold))
                
                Spacer()
                
                Text("See all")
                    .foregroundColor(.blue)
                    .font(.system(size: 13, weight: .semibold))
            }
            .padding(15)
            VStack(spacing: 12){
                ForEach(nearbyHotels) { hotel in
                                    HotelNearByCardView(hotel: hotel)
                                }
                
                Spacer()
                
            }
            .padding(.horizontal)
            .padding(.top,-15)
            
        }
        
        
        
        
        .background(Color("AppBgColor"))
        .padding(.top,10)
    }
}


struct HotelNearByCardView: View {
    
    let hotel: Hotel
    @State var cardWidth = UIScreen.main.bounds.width - 32
    @State var cardHeight = UIScreen.main.bounds.width / 2.7
    
    var body: some View {
        NavigationLink(destination: BookingView(hotel: hotel)) {
                ZStack {
                    Image(hotel.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: cardWidth, height: cardHeight)
                        .clipped()
                    
                    VStack {
                        HStack {
                            // Distance and time (static or mock-up for now)
                            HStack {
                                Image(systemName: "car.fill")
                                    .foregroundColor(Color("DarkBlue"))
                                    .font(.system(size: 12))
                                    .padding(.trailing , -3)
                                Text("\(hotel.distanceFromCenter) / 2 min") // Adjust as needed
                                    .foregroundColor(Color("DarkBlue"))
                                    .font(.system(size: 12, weight: .bold))
                                    .opacity(0.8)
                            }
                            .padding(.horizontal, 5)
                            .padding(.vertical, 2)
                            .background(Color.white.opacity(0.4).blur(radius: 0.5))
                            .background(.ultraThinMaterial)
                            .cornerRadius(10)
                            .padding(10)
                            
                            Spacer()
                            
                            // Rating
                            HStack {
                                Image(systemName: "star.fill")
                                    .foregroundColor(Color("DarkBlue"))
                                    .font(.system(size: 12))
                                    .padding(.trailing , -3)
                                Text("\(hotel.rating)")
                                    .foregroundColor(.black)
                                    .font(.system(size: 12, weight: .bold))
                                    .opacity(0.8)
                            }
                            .padding(.horizontal, 5)
                            .padding(.vertical, 2)
                            .background(Color.white.opacity(0.4).blur(radius: 0.5))
                            .background(.ultraThinMaterial)
                            .cornerRadius(10)
                            .padding(10)
                        }
                        
                        Spacer()
                        
                        // Hotel Info
                        HStack {
                            VStack(alignment: .leading, spacing: 2) {
                                HStack {
                                    Text(hotel.name)
                                        .foregroundColor(.white)
                                        .font(.system(size: 12, weight: .semibold))
                                    Text("• \(hotel.distanceFromCenter) from center")
                                        .foregroundColor(.white)
                                        .font(.system(size: 12, weight: .semibold))
                                    Spacer()
                                    Text(String(format: "$%.2f", hotel.price))
                                        .foregroundColor(.white)
                                        .font(.system(size: 12, weight: .semibold))
                                }
                                
                                HStack {
                                    Text(hotel.location)
                                        .foregroundColor(.white)
                                        .font(.system(size: 8, weight: .regular))
                                        .opacity(0.7)
                                    Spacer()
                                    Text(hotel.boardType)
                                        .foregroundColor(.white)
                                        .font(.system(size: 8, weight: .regular))
                                }
                            }
                            
                            Spacer()
                        }
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .background(Color("LightBlue"))
                    }
                }
                .background(Color("AppBg"))
                .frame(width: cardWidth, height: cardHeight)
                .cornerRadius(12)
            }
        
    }
}




extension Color {
    init?(hex: String) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexString.hasPrefix("#") {
            hexString.removeFirst()
        }
        
        guard hexString.count == 6 || hexString.count == 8 else {
            return nil
        }
        
        var rgb: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgb)
        
        let r, g, b, a: Double
        if hexString.count == 6 {
            r = Double((rgb & 0xFF0000) >> 16) / 255
            g = Double((rgb & 0x00FF00) >> 8) / 255
            b = Double(rgb & 0x0000FF) / 255
            a = 1.0
        } else {
            r = Double((rgb & 0xFF000000) >> 24) / 255
            g = Double((rgb & 0x00FF0000) >> 16) / 255
            b = Double((rgb & 0x0000FF00) >> 8) / 255
            a = Double(rgb & 0x000000FF) / 255
        }
        
        self.init(.sRGB, red: r, green: g, blue: b, opacity: a)
    }
}


