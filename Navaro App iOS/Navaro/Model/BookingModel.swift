//
//  BookingModel.swift
//  Navaro
//
//  Created by Guest User on 2025-09-09.
//

import Foundation
import FirebaseFirestore

struct Booking: Identifiable, Codable {
    @DocumentID var id: String?
    let hotelName: String
    let checkIn: Date
    let checkOut: Date
    let rooms: Int
    let price: Double
    let status: String
    var userEmail: String? = ""
}
