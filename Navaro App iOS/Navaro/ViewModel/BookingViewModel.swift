//
//  BookingViewModel.swift
//  Navaro
//
//  Created by Guest User on 2025-09-09//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class BookingViewModel: ObservableObject {
    @Published var bookings: [Booking] = []
    @Published var upcomingBookings: [Booking] = []
    @Published var pastBookings: [Booking] = []
    
    init() {
        fetchBookings()
    }
    
    private let db = Firestore.firestore()
    
    func fetchBookings(for userEmail: String) {
        db.collection("bookings")
            .whereField("userEmail", isEqualTo: userEmail)
            .order(by: "checkIn", descending: true)
            .getDocuments { snapshot, error in
                guard let documents = snapshot?.documents else { return }
                self.bookings = documents.compactMap {
                    try? $0.data(as: Booking.self)
                }
            }
    }
    
    func addBooking(hotelName: String, checkIn: Date, checkOut: Date, rooms: Int, price: Double, status: String, userEmail: String) {
        let newBooking = Booking(id: nil, hotelName: hotelName, checkIn: checkIn, checkOut: checkOut, rooms: rooms, price: price, status: status, userEmail: userEmail)
        
        do {
            _ = try db.collection("bookings").addDocument(from: newBooking)
        } catch {
            print("Error adding booking: \(error)")
        }
    }
    
    func fetchBookings() {
        guard let userEmail = Auth.auth().currentUser?.email else {
            print("User not logged in.")
            return
        }
        
        db.collection("bookings")
            .whereField("userEmail", isEqualTo: userEmail)
            .order(by: "checkIn", descending: false)
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    print("Error fetching bookings: \(error.localizedDescription)")
                    return
                }
                
                guard let documents = snapshot?.documents else { return }
                
                let now = Date()
                var upcoming: [Booking] = []
                var past: [Booking] = []
                
                for doc in documents {
                    let data = doc.data()
                    
                    if
                        let hotelName = data["hotelName"] as? String,
                        let checkInTimestamp = data["checkIn"] as? Timestamp,
                        let checkOutTimestamp = data["checkOut"] as? Timestamp,
                        let rooms = data["rooms"] as? Int,
                        let price = data["price"] as? Double,
                        let status = data["status"] as? String
                    {
                        let checkIn = checkInTimestamp.dateValue()
                        let checkOut = checkOutTimestamp.dateValue()
                        
                        let booking = Booking(
                            hotelName: hotelName,
                            checkIn: checkIn,
                            checkOut: checkOut,
                            rooms: rooms,
                            price: price,
                            status: status
                        )
                        
                        if checkIn >= now {
                            upcoming.append(booking)
                        } else {
                            past.append(booking)
                        }
                    }
                }
                
                self.upcomingBookings = upcoming
                self.pastBookings = past
            }
    }
}
