//
//  WishlistView.swift
//  furniture-finalproject
//
//  Created by andra-dev on 15/08/24.
//

import SwiftUI

struct WishlistView: View {
    @EnvironmentObject var wishlistViewModel: WishlistViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
            VStack(spacing: 0) {
                // Custom Navigation Bar
                ZStack {
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.primary)
                                .imageScale(.large)
                        }
                        Spacer()
                    }
                    .padding(.leading)
                    
                    Text("Wishlist")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.primary)
                }
                .frame(height: 44)
                
                if wishlistViewModel.wishlistItems.isEmpty {
                    emptyStateView
                } else {
                    wishlistItemsView
                }
            }
            .navigationBarHidden(true)
        }
    
    private var emptyStateView: some View {
        VStack {
            Spacer()
            Text("Your wishlist is empty")
                .font(.headline)
            Text("Items you add to your wishlist will appear here")
                .font(.subheadline)
                .foregroundColor(.gray)
            Spacer()
        }
    }
    
    private var wishlistItemsView: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(wishlistViewModel.wishlistItems) { item in
                    WishlistItemView(item: item)
                }
            }
            .padding()
        }
    }
}

struct WishlistItemView: View {
    let item: Product
    @EnvironmentObject var wishlistViewModel: WishlistViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(item.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 120)
                .cornerRadius(8)
            
            Text(item.name)
                .font(.subheadline)
                .lineLimit(2)
            
            Text("Rp\(item.price)")
                .font(.caption)
                .foregroundColor(.gray)
            
            Button(action: {
                wishlistViewModel.removeFromWishlist(item: item)
            }) {
                Text("Remove")
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.black)
                    .cornerRadius(8)
            }
        }
        .padding(8)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}
#Preview {
    WishlistView()
}
