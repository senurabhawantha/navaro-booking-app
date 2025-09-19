//
//  HotelModel.swift
//  Navaro
//
//  Created by Guest User on 2025-09-09
//

import Foundation
import CoreLocation

struct Hotel: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let location: String
    let distanceFromCenter: String
    let price: Double
    let rating: Int
    let boardType: String
    let imageName: String
    let coordinates: CLLocationCoordinate2D
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(location)
        hasher.combine(distanceFromCenter)
        hasher.combine(price)
        hasher.combine(rating)
        hasher.combine(boardType)
        hasher.combine(imageName)
        hasher.combine(coordinates.latitude)
        hasher.combine(coordinates.longitude)
    }
    
    static func == (lhs: Hotel, rhs: Hotel) -> Bool {
        return lhs.id == rhs.id &&
               lhs.name == rhs.name &&
               lhs.location == rhs.location &&
               lhs.distanceFromCenter == rhs.distanceFromCenter &&
               lhs.price == rhs.price &&
               lhs.rating == rhs.rating &&
               lhs.boardType == rhs.boardType &&
               lhs.imageName == rhs.imageName &&
               lhs.coordinates == rhs.coordinates
    }
}
