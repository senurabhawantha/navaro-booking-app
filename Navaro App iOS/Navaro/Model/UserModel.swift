//
//  UserModel.swift
//  Navaro
//
//  Created by Guest User on 2025-09-09
//

import Foundation
import FirebaseAuth

struct UserModel: Identifiable, Codable {
    let id: String
    let email: String?
    let displayName: String?
    let photoURL: URL?

    init(from user: User) {
        self.id = user.uid
        self.email = user.email
        self.displayName = user.displayName
        self.photoURL = user.photoURL
    }

    init(id: String, data: [String: Any]) {
        self.id = id
        self.email = data["email"] as? String
        let firstName = data["firstName"] as? String ?? ""
        let lastName = data["lastName"] as? String ?? ""
        self.displayName = "\(firstName) \(lastName)".trimmingCharacters(in: .whitespaces)
        self.photoURL = nil
    }
}
