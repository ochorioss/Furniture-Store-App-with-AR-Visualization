//
//  ProductDetailView.swift
//  furniture-finalproject
//
//  Created by andra-dev on 15/08/24.
//

import SwiftUI

struct ProductDetailView: View {
    let item: Product
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var cartViewModel: CartViewModel
    @EnvironmentObject var wishlistViewModel: WishlistViewModel
    
    @State private var showingAlert = false
    @State private var showARView = false
    @State private var showingBuyNow = false
    
    var body: some View {
        ZStack{
            ScrollView {
                VStack(alignment: .center, spacing: 20) {
                    Image(item.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 300)
                        .cornerRadius(10)
                        .overlay(
                            VStack {
                                Spacer()
                                HStack {
                                    Spacer()
                                    ARButton{
                                        showARView = true
                                    }
                                    .padding(8)
                                }
                            }
                        )
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.title2)
                                .fontWeight(.bold)
                            Text("Rp\(formatPrice(item.price))")
                                .font(.title3)
                                .foregroundColor(.black)
                            HStack {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.black)
                                Text(String(format: "%.1f", item.rating))
                                Text("\(item.soldCount) Sold")
                                    .foregroundColor(.gray)
                            }
                        }
                        Spacer()
                        Button {
                            wishlistViewModel.toggleWishlistStatus(for: item)
                            print("Wishlist items after toggle: \(wishlistViewModel.wishlistItems)")
                        } label: {
                            Image(systemName: wishlistViewModel.isInWishlist(item: item) ? "heart.fill" : "heart")
                                .foregroundColor(wishlistViewModel.isInWishlist(item: item) ? .black : .gray)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Product Description")
                            .font(.headline)
                        Text(item.description)
                            .font(.body)
                    }
                    
                    HStack {
                        Button(action: {
                            cartViewModel.addToCart(item: item)
                            withAnimation (.easeInOut(duration: 0.5)){
                                showingAlert = true
                            }
                                dismissAlert()
                        }) {
                            HStack (spacing: 8){
                                Image(systemName: "cart")
                                    .foregroundStyle(Color.white)
                                
                                Text("Add to Cart")
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(LinearGradient(colors: [.gray, .black], startPoint: .bottomLeading, endPoint: .topTrailing))
                            .cornerRadius(10)
                        }
                        
                        Button(action: {
                            showingBuyNow = true
                        }) {
                            Text("Buy Now")
                                .foregroundColor(.black)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.black, lineWidth: 1)
                                )
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Detail Product")
            .navigationBarTitleDisplayMode(.inline)
            
            if showingAlert {
                    CustomAlertView(
                        title: "Added to Cart",
                        message: "\(item.name) has been added to your cart.",
                        isPresented: $showingAlert
                    )
                }
            }
        .sheet(isPresented: $showARView, content: {
            ARInstructionsView(item: item)
        })
        .sheet(isPresented: $showingBuyNow, content: {
            BuyNowView(item: item)
        })
        
        }
    private func dismissAlert() {
           DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
               withAnimation (.easeInOut(duration: 0.5)){
                   showingAlert = false
               }
           }
       }
    }
    

    
    private func formatPrice(_ price: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        return formatter.string(from: NSNumber(value: price)) ?? "\(price)"
    }


    struct ARButton: View {
        let action: () -> Void
        
        var body: some View {
            Button(action: action) {
                Image(systemName: "arkit")
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(8)
            }
        }
    }


// Preview
struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProductDetailView(item: Product(
                name: "Woodrobe",
                description: "Introducing the Woodrobe, a stunning wooden wardrobe that combines timeless elegance with practical storage solutions. Crafted from high-quality, sustainably sourced wood, this versatile piece of furniture seamlessly blends with any decor while providing ample space for your clothing and accessories.",
                price: 5500000,
                rating: 4.5,
                soldCount: 390,
                imageName: "woodrobe",
                bannerImageName: "",
                modelName: ""
            ))
        }
    }
}
