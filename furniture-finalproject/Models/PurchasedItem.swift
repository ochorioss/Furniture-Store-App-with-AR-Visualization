//
//  PurchasedItem.swift
//  furniture-finalproject
//
//  Created by andra-dev on 20/08/24.
//

import Foundation

struct PurchasedItem: Identifiable {
    let id: UUID
    let name: String
    let price: Int
    let quantity: Int
    let imageName: String
    
    init(id: UUID = UUID(), name: String, price: Int, quantity: Int, imageName: String) {
        self.id = id
        self.name = name
        self.price = price
        self.quantity = quantity
        self.imageName = imageName
    }
}
