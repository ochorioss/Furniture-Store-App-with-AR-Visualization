//
//  CartViewModel.swift
//  furniture-finalproject
//
//  Created by andra-dev on 15/08/24.
//

import Foundation
import SwiftUI

class CartViewModel: ObservableObject {
    @Published var cartItems: [CartItem] = []
    @Published var selectAll: Bool = false {
        didSet {
            cartItems = cartItems.map { CartItem(id: $0.id, name: $0.name, price: $0.price, quantity: $0.quantity, imageName: $0.imageName, isSelected: selectAll, isFavorite: $0.isFavorite) }
        }
    }
    
    init() {
        // You can keep your sample data or remove it if you want to start with an empty cart
    }
    
    var total: Int {
        cartItems.filter { $0.isSelected }.reduce(0) { $0 + $1.price * $1.quantity }
    }
    
    func addToCart(item: Product) {
        if let index = cartItems.firstIndex(where: { $0.id == item.id }) {
            cartItems[index].quantity += 1
        } else {
            let newItem = CartItem(id: item.id, name: item.name, price: item.price, quantity: 1, imageName: item.imageName, isSelected: true, isFavorite: false)
            cartItems.append(newItem)
        }
    }
    
    func removeFromCart(item: CartItem) {
        cartItems.removeAll { $0.id == item.id }
    }
    
    func toggleItemSelection(_ item: CartItem) {
        if let index = cartItems.firstIndex(where: { $0.id == item.id }) {
            cartItems[index].isSelected.toggle()
        }
    }
    
    func toggleFavorite(_ item: CartItem) {
        if let index = cartItems.firstIndex(where: { $0.id == item.id }) {
            cartItems[index].isFavorite.toggle()
        }
    }
    
    func incrementQuantity(_ item: CartItem) {
        if let index = cartItems.firstIndex(where: { $0.id == item.id }) {
            cartItems[index].quantity += 1
        }
    }
    
    func decrementQuantity(_ item: CartItem) {
        if let index = cartItems.firstIndex(where: { $0.id == item.id }) {
            if cartItems[index].quantity > 1 {
                cartItems[index].quantity -= 1
            } else {
                removeFromCart(item: item)
            }
        }
    }
}
