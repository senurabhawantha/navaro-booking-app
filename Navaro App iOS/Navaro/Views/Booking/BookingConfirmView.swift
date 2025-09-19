//
//  BookingConfirmView.swift
//  Navaro
//
//  Created by Guest User on 2025-09-09
//

import SwiftUI
import FirebaseAuth
import CoreLocation
import UserNotifications


struct BookingConfirmView: View {
    let hotel: Hotel?
    @State private var checkIn = Date()
    @State private var checkOut = Date().addingTimeInterval(86400)
    @State private var rooms = 1
    
    @State private var cardNumber = ""
    @State private var expiryDate = ""
    @State private var cvv = ""
    @State private var nameOnCard = ""
    
    @StateObject private var viewModel = BookingViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var totalPrice: Double {
        guard let hotel = hotel else { return 0 }
        return Double(rooms) * hotel.price
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 25) {
                if let hotel = hotel {
                    HStack{
                    VStack(alignment: .leading, spacing: 0) {
                        Text(hotel.name)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.darkBlue)
                        
                        Text("Confirm Your Booking")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                }
                    .padding(.horizontal)
                    .padding(.top,10)
                    
                    
                }
                
                GroupBox {
                    VStack(spacing: 5) {
                        HStack {
                            Text("Check-in date")
                            Spacer()
                            DatePicker("", selection: $checkIn, displayedComponents: .date)
                                .labelsHidden()
                        }
                        
                        HStack {
                            Text("Check-out date")
                            Spacer()
                            DatePicker("", selection: $checkOut, displayedComponents: .date)
                                .labelsHidden()
                        }
                        
                        Stepper("No of Rooms: \(rooms)", value: $rooms, in: 1...10)
                            .padding(.top, 10)
                    }
                    .padding(10)
                } label: {
                    Label("Stay Details", systemImage: "calendar")
                        .foregroundColor(.darkBlue)
                }
                .padding(.horizontal)
                
                GroupBox {
                    VStack(spacing: 10) {
                        TextField("Name on Card", text: $nameOnCard)
                            .padding()
                            .background(.white)
                            .cornerRadius(8)
    
                        TextField("Card Number", text: $cardNumber)
                            .keyboardType(.numberPad)
                            .padding()
                            .background(.white)
                            .cornerRadius(8)
                        
                        HStack{
                            TextField("Expiry Date (MM/YY)", text: $expiryDate)
                                .padding()
                                .background(.white)
                                .cornerRadius(8)
                            
                            TextField("CVV", text: $cvv)
                                .keyboardType(.numberPad)
                                .padding()
                                .background(.white)
                                .cornerRadius(8)
                                .frame(width: 120)
                        }
                        
                      
                    }
                } label: {
                    Label("Payment Info", systemImage: "creditcard")
                        .foregroundColor(.darkBlue)
                }
                .padding(.horizontal)
                
                VStack(spacing: 10) {
                    HStack{
                        Text("Total Price")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Text("$\(String(format: "%.2f", totalPrice))")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                Button(action: bookNow) {
                    Text("BOOK NOW")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(12)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
            }
            .frame(maxWidth: .infinity)
        }
        .navigationTitle("Booking")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func bookNow() {
        guard let userEmail = Auth.auth().currentUser?.email else {
            print("User not logged in")
            return
        }
        
        guard let hotel = hotel else { return }
        
        viewModel.addBooking(
            hotelName: hotel.name,
            checkIn: checkIn,
            checkOut: checkOut,
            rooms: rooms,
            price: totalPrice,
            status: "Confirmed",
            userEmail: userEmail
        )
        
        sendConfirmationNotification(hotelName: hotel.name)
        
        presentationMode.wrappedValue.dismiss()
    }
    
    private func sendConfirmationNotification(hotelName: String) {
        let content = UNMutableNotificationContent()
        content.title = "Booking Confirmed 🎉"
        content.body = "Your stay at \(hotelName) is booked successfully!"
        content.sound = .default
        content.userInfo = ["action": "open_booking"]

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Failed to schedule notification: \(error.localizedDescription)")
            }
        }
    }


}






#Preview {
    BookingConfirmView(hotel: Hotel(
        name: "Sunrise Resort",
        location: "Maldives",
        distanceFromCenter: "0.5 km",
        price: 299.99,
        rating: 5,
        boardType: "All Inclusive",
        imageName: "resort_image",
        coordinates: CLLocationCoordinate2D(latitude: 3.2028, longitude: 73.2207)
    ))
}
