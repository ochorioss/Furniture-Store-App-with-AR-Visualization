//
//  Checkout.swift
//  furniture-finalproject
//
//  Created by andra-dev on 19/08/24.
//

import Foundation

struct Address: Identifiable {
    let id = UUID()
    let type: String
    let street: String
    let city: String
    let name: String
    let phone: String
}

struct ShippingMethod: Identifiable {
    let id = UUID()
    let name: String
    let estimatedDelivery: String
    let price: Int
}

enum PaymentMethod: String, CaseIterable {
    case creditCard = "Credit Card"
    case paypal = "PayPal"
}
