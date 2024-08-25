//
//  PaymentMethod.swift
//  furniture-finalproject
//
//  Created by andra-dev on 20/08/24.
//

import Foundation

enum PaymentMethod: String, CaseIterable, Identifiable {
    case creditCard = "Credit Card"
    case paypal = "PayPal"
    
    var id: String { self.rawValue }
}
