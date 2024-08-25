//
//  WishlistViewModel.swift
//  furniture-finalproject
//
//  Created by andra-dev on 19/08/24.
//

import SwiftUI

class WishlistViewModel: ObservableObject {
    @Published var wishlistItems: [Product] = []
    
    func addToWishlist(item: Product) {
            if !isInWishlist(item: item) {
                wishlistItems.append(item)
                print("Added to wishlist: \(item.name)")
        }
    }
    
    func toggleWishlistStatus(for item: Product) {
        if isInWishlist(item: item) {
            removeFromWishlist(item: item)
        } else {
            addToWishlist(item: item)
        }
        print("Wishlist items after toggle: \(wishlistItems.map { $0.name })")
    }
    
    func removeFromWishlist(item: Product) {
            wishlistItems.removeAll { $0.id == item.id }
            print("Removed from wishlist: \(item.name)")
    }
    
    func isInWishlist(item: Product) -> Bool {
            return wishlistItems.contains { $0.id == item.id }
    }
}
