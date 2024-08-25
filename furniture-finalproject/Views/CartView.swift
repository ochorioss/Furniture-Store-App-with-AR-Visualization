//
//  CartView.swift
//  furniture-finalproject
//
//  Created by andra-dev on 15/08/24.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var viewModel: CartViewModel
    @State private var showingCheckout = false
    
    var body: some View {
        VStack(spacing: 0) {
            SelectAllToggle(isSelected: $viewModel.selectAll)
            
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.cartItems) { item in
                        CartItemView(item: item)
                    }
                }
                .padding()
            }
            
            VStack(spacing: 16) {
                HStack {
                    Text("Total")
                        .font(.headline)
                    Spacer()
                    Text("Rp\(viewModel.total)")
                        .font(.headline)
                }
                
                Button(action: {
                    showingCheckout = true
                }) {
                    Text("Checkout")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(LinearGradient(colors: [.gray, .black], startPoint: .bottomLeading, endPoint: .topTrailing))
                        .foregroundColor(.white)
                        .cornerRadius(15)
                }
            }
            .padding()
        }
        .navigationTitle("My Cart")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showingCheckout, content: {
            CheckoutView(cartItems: viewModel.cartItems)
        })
    }
}

struct SelectAllToggle: View {
    @Binding var isSelected: Bool
    
    var body: some View {
        HStack {
            Button(action: { isSelected.toggle() }) {
                Image(systemName: isSelected ? "checkmark.square.fill" : "square")
                    .foregroundColor(isSelected ? .black : .gray)
            }
            Text("Select All")
            Spacer()
        }
        .padding()
    }
}

struct CartItemView: View {
    let item: CartItem
    @EnvironmentObject var viewModel: CartViewModel
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Button(action: { viewModel.toggleItemSelection(item) }) {
                Image(systemName: item.isSelected ? "checkmark.square.fill" : "square")
                    .foregroundColor(item.isSelected ? .black : .gray)
            }
            
            Image(item.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 4) {
                HStack (spacing: 16){
                    Text(item.name)
                        .font(.headline)
                    
                    Button {
                        viewModel.removeFromCart(item: item)
                    } label: {
                        Image(systemName: "trash")
                            .font(.system(size: 17))
                            .foregroundStyle(.red)
                    }

                }
                Text("Rp\(item.price)")
                    .foregroundColor(.gray)
                
                HStack {
                    Button(action: {
                        viewModel.toggleFavorite(item)
                    }) {
                        Image(systemName: item.isFavorite ? "heart.fill" : "heart")
                            .foregroundColor(item.isFavorite ? .red : .gray)
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 12) {
                        Button(action: { viewModel.decrementQuantity(item) }) {
                            Image(systemName: "minus")
                                .foregroundStyle(.black)
                                .padding(8)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                        }
                        
                        Text("\(item.quantity)")
                        
                        Button(action: { viewModel.incrementQuantity(item) }) {
                            Image(systemName: "plus")
                                .foregroundStyle(.black)
                                .padding(8)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                        }
                    }
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(CartViewModel())
    }
}
