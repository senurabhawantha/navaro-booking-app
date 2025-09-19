//
//  BookingView.swift
//  Navaro
//
//  Created by Guest User on 2025-09-09
//

import SwiftUI
import CoreLocation

struct BookingView: View {
    let hotel: Hotel
    @Environment(\.presentationMode) var presentationMode

    
    var body: some View {
        ScrollView{
            ZStack {
                VStack {
                    VStack(){
                        ZStack(alignment: .topLeading) {
                            
                            Image("h1") // <- Use passed hotel image
                                .resizable()
                                .ignoresSafeArea()
                            
                            
//                            Button(action: {
//                                presentationMode.wrappedValue.dismiss()
//                            }) {
//                                Image(systemName: "chevron.left")
//                                    .font(.title2)
//                                    .foregroundColor(.white)
//                                    .padding(10)
//                                    .background(Color.black.opacity(0.5))
//                                    .clipShape(Circle())
//                                    .padding(.top, 10)
//                                    .padding(.leading, 20)
//                            }
                            
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: UIScreen.main.bounds.width / 1.2)
                        .aspectRatio(contentMode: .fill)
                        
                        HStack {
                            VStack(alignment: .leading , spacing: 5){
                                Text(hotel.name)
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(.darkBlue)
                                HStack {
                                    Text(hotel.location)
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundColor(.darkBlue)
                                        .opacity(0.6)
                                    Text("• \(hotel.distanceFromCenter)")
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundColor(.darkBlue)
                                        .opacity(0.6)
                                    Spacer()
                                }
                                
                                
                                HStack(alignment: .lastTextBaseline) {
                                    Text("$\(hotel.price, specifier: "%.2f")/")
                                        .font(.system(size: 24, weight: .semibold))
                                        .foregroundColor(.lightBlue)
                                    Text("1 night")
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundColor(.darkBlue)
                                        .opacity(0.6)
                                        .padding(.leading ,-5)
                                    Spacer()
                                }
                            }
                            Spacer()
                        }
                        .padding(20)
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(30)
                        .padding(.top, -40)
                        
                        BookingReviwsCardView()
                        WeatherView()
                        ARButton()
                        BookingFacilitiesView()
                        Spacer()
                        
                        NavigationLink(destination: BookingConfirmView(hotel: hotel)) {
                            Text("BOOK NOW")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.black)
                                .cornerRadius(12)
                                .padding(.horizontal ,20)
                                .padding(.bottom)
                        }
                    }
                }
            }
        }
        .ignoresSafeArea(edges: .top)
        .navigationBarBackButtonHidden(false)
    }
}


import SwiftUI

struct ARButton: View {
    @State private var showARView = false

    var body: some View {
        Button(action: {
            showARView = true
        }) {
            HStack {
                Spacer()
                Text("Show AR View")
                    .foregroundColor(.blue)
                    .padding()
                Spacer()
            }
            .background(Color.clear)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.blue, lineWidth: 1.5)
            )
            .cornerRadius(12)
            .padding(.horizontal)
        }
        .sheet(isPresented: $showARView) {
            ARView()
        }
    }
}



struct Facility: Identifiable {
    let id = UUID()
    let iconName: String
    let label: String
}

let facilities: [Facility] = [
    .init(iconName: "wifi", label: "Free Wifi"),
    .init(iconName: "figure.walk", label: "Gym"),
    .init(iconName: "drop.fill", label: "Pool"),
    .init(iconName: "fork.knife", label: "Full Kitchen"),
    .init(iconName: "wind", label: "Air Con")
]

struct BookingFacilitiesView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Popular amenities")
                .font(.headline)
                .padding(.horizontal, 20)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(facilities) { facility in
                        VStack(spacing: 8) {
                            Image(systemName: facility.iconName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.darkBlue)
                            
                            Text(facility.label)
                                .font(.caption)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.darkBlue)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: .gray.opacity(0.1), radius: 2, x: 0, y: 2)
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .padding(.top, 10)
    }
}

struct BookingReviwsCardView: View {
    let sampleAvatars = ["person.circle", "person.circle.fill", "person.2.circle", "person.3"]
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Reviews")
                        .font(.headline)
                        .foregroundColor(.darkBlue)
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text("4.9")
                            .bold()
                        Text("(1120 reviews)")
                            .foregroundColor(.gray)
                    }
                    .font(.subheadline)
                }

                Spacer()

                HStack(spacing: -10) {
                    ForEach(sampleAvatars.indices, id: \.self) { i in
                        Image(systemName: sampleAvatars[i])
                            .resizable()
                            .scaledToFill()
                            .frame(width: 28, height: 28)
                            .clipShape(Circle())
                            .background(Circle().fill(Color.white))
                            .overlay(Circle().stroke(Color.white, lineWidth: 1))
                            .shadow(radius: 1)
                    }
                }

                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.darkBlue, lineWidth: 0.2)
        )
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 1)
        .padding(.horizontal, 20)
    }
}


import SwiftUI

struct WeatherView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @State private var cityInput = "Weligama"

    var body: some View {
        VStack(spacing: 20) {
            HStack{
                
                if let iconURL = viewModel.iconURL {
                    AsyncImage(url: iconURL) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 100, height: 100)
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("\(viewModel.temperature) \(viewModel.description) - \(viewModel.clothingAdvice)")
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.horizontal)
                }

                
                
            }
           
        }
        .padding()
        .onAppear {
            viewModel.fetchWeather(for: cityInput)
        }
    }
}





#Preview {
    BookingView(hotel: Hotel(
        name: "Airport Resort",
        location: "Katunayaka",
        distanceFromCenter: "0.5 km",
        price: 299.99,
        rating: 5,
        boardType: "All Inclusive",
        imageName: "resort_image",
        coordinates: CLLocationCoordinate2D(latitude: 3.2028, longitude: 73.2207)
    ))
}
