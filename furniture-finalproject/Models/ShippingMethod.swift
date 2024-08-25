//
//  ShippingMethod.swift
//  furniture-finalproject
//
//  Created by andra-dev on 20/08/24.
//

import Foundation

struct ShippingMethod: Identifiable {
    let id: UUID
    let name: String
    let estimatedDelivery: String
    let price: Int
    
    init(id: UUID = UUID(), name: String, estimatedDelivery: String, price: Int) {
        self.id = id
        self.name = name
        self.estimatedDelivery = estimatedDelivery
        self.price = price
    }
}
