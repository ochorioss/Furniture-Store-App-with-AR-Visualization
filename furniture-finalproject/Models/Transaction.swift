//
//  Transaction.swift
//  furniture-finalproject
//
//  Created by andra-dev on 19/08/24.
//

import Foundation

struct Transaction: Identifiable {
    let id: UUID
    let date: Date
    let items: [PurchasedItem]
    let total: Int
    let shippingMethod: ShippingMethod
    let paymentMethod: PaymentMethod
    
    init(id: UUID = UUID(), date: Date, items: [PurchasedItem], total: Int, shippingMethod: ShippingMethod, paymentMethod: PaymentMethod) {
        self.id = id
        self.date = date
        self.items = items
        self.total = total
        self.shippingMethod = shippingMethod
        self.paymentMethod = paymentMethod
    }
}

