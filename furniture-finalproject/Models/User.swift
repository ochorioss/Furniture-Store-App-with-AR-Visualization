//
//  User.swift
//  furniture-finalproject
//
//  Created by andra-dev on 20/08/24.
//
import Foundation

struct User: Identifiable, Codable {
    let id: UUID
    var firstName: String
    var lastName: String
    var email: String
    var phoneNumber: String
    var profileImageData: Data?
    
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
    
    init(id: UUID = UUID(), firstName: String, lastName: String, email: String, phoneNumber: String, profileImageData: Data? = nil) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phoneNumber = phoneNumber
        self.profileImageData = profileImageData
    }
}
