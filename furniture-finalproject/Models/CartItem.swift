//
//  CartItem.swift
//  furniture-finalproject
//
//  Created by andra-dev on 19/08/24.
//

import Foundation

struct CartItem: Identifiable, Equatable {
    let id: UUID
    let name: String
    let price: Int
    var quantity: Int
    let imageName: String
    var isSelected: Bool
    var isFavorite: Bool
    
    var totalPrice: Int {
        return price * quantity
    }
    
    init(id: UUID = UUID(), name: String, price: Int, quantity: Int, imageName: String, isSelected: Bool, isFavorite: Bool) {
        self.id = id
        self.name = name
        self.price = price
        self.quantity = quantity
        self.imageName = imageName
        self.isSelected = isSelected
        self.isFavorite = isFavorite
    }
}
