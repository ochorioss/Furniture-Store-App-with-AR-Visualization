//
//  Address.swift
//  furniture-finalproject
//
//  Created by andra-dev on 20/08/24.
//

import Foundation

struct Address: Identifiable {
    let id: UUID
    let type: String
    let street: String
    let city: String
    let name: String
    let phone: String
    
    init(id: UUID = UUID(), type: String, street: String, city: String, name: String, phone: String) {
        self.id = id
        self.type = type
        self.street = street
        self.city = city
        self.name = name
        self.phone = phone
    }
}
