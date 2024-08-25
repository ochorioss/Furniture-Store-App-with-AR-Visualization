//
//  CheckoutView.swift
//  furniture-finalproject
//
//  Created by andra-dev on 19/08/24.
//

import SwiftUI

struct CheckoutView: View {
    @StateObject private var viewModel : CheckoutViewModel
    @EnvironmentObject var transactionHistoryViewModel : TransactionHistoryViewModel
    @State private var showShippingOptions = false
    @Environment(\.presentationMode) var presentationMode


       init(cartItems: [CartItem]) {
           _viewModel = StateObject(wrappedValue: CheckoutViewModel(cartItems: cartItems, transactionHistoryViewModel: TransactionHistoryViewModel()))
       }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Navigation bar
                NavigationBar(action: { presentationMode.wrappedValue.dismiss() })
                
                // Shipping Address
                ShippingAddressView(address: viewModel.selectedAddress)
                
                // Items in cart
                ItemsView(items: viewModel.cartItems)
                
                // Shipping Method
                ShippingMethodView(
                    selectedMethod: viewModel.selectedShippingMethod,
                    showOptions: $showShippingOptions
                )
                
                // Payment Method
                PaymentMethodView(selectedMethod: $viewModel.selectedPaymentMethod)
                
                // Subtotal
                SubtotalView(subtotal: viewModel.subtotal, total: viewModel.total)
                
                // Pay Button
                PayButton(action: viewModel.processPayment)
            }
            .padding()
        }
        .onAppear {
                    viewModel.setTransactionHistoryViewModel(transactionHistoryViewModel)
                }
        .navigationBarHidden(true)
        .sheet(isPresented: $showShippingOptions) {
            ShippingOptionsView(
                methods: viewModel.shippingMethods,
                selectedMethod: viewModel.selectedShippingMethod,
                selectMethod: viewModel.selectShippingMethod
            )
        }
        .alert(isPresented: $viewModel.showSuccessAlert) {
            Alert(
                title: Text("Purchase Successful"),
                message: Text("Your order has been placed successfully."),
                dismissButton: .default(Text("OK")) {
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
}

struct NavigationBar: View {
    let action: () -> Void

    var body: some View {
        HStack {
            Button(action: action) {
                Image(systemName: "arrow.left")
                    .foregroundColor(.black)
            }
            Spacer()
            Text("Checkout")
                .font(.headline)
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct ShippingAddressView: View {
    let address: Address?

    var body: some View {
        Button(action: {
            // Action to show list of addresses
        }) {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: "map")
                    Text("Shipping Address")
                        .font(.headline)
                }
                
                if let address = address {
                    HStack {
                        Text(address.type)
                            .font(.caption)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                        
                        VStack(alignment: .leading) {
                            Text(address.street)
                            Text(address.city)
                        }
                        .font(.caption)
                    }
                    
                    HStack {
                        Text(address.name)
                        Text(address.phone)
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .font(.caption)
                }
            }
        }
        .foregroundColor(.black)
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
    }
}

struct ItemsView: View {
    let items: [CartItem]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Items")
                .font(.headline)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(items) { item in
                        ItemView(item: item)
                    }
                }
            }
        }
    }
}

struct ItemView: View {
    let item: CartItem
    
    var body: some View {
        VStack {
            Image(item.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
            Text(item.name)
                .font(.caption)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1.5))
    }
}
struct ShippingMethodView: View {
    let selectedMethod: ShippingMethod?
    @Binding var showOptions: Bool

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Select Shipping")
                    .font(.headline)
                Spacer()
                Button("See all options") {
                    showOptions = true
                }
                .font(.caption)
                .foregroundColor(.gray)
            }
            
            if let method = selectedMethod {
                ShippingMethodRow(method: method)
            } else {
                Text("Select a shipping method")
                    .foregroundColor(.gray)
            }
        }
    }
}

struct ShippingMethodRow: View {
    let method: ShippingMethod
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(method.name)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                Text(method.estimatedDelivery)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
            Text("Rp\(method.price)")
                .font(.subheadline)
                .foregroundStyle(.black)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
    }
}

struct PaymentMethodView: View {
    @Binding var selectedMethod: PaymentMethod?

    var body: some View {
        VStack(alignment: .leading) {
            Text("Payment Method")
                .font(.headline)
            
            HStack {
                ForEach(PaymentMethod.allCases, id: \.self) { method in
                    PaymentOptionButton(
                        image: imageFor(method),
                        text: method.rawValue,
                        isSelected: method == selectedMethod,
                        action: { selectedMethod = method }
                    )
                }
            }
        }
    }
    
    private func imageFor(_ method: PaymentMethod) -> String {
           switch method {
           case .creditCard: return "creditcard"
           case .paypal: return "p.circle.fill"
           }
       }
   }

struct PaymentOptionButton: View {
    let image: String
    let text: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 30)
                Text(text)
                    .font(.caption)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).stroke(isSelected ? Color.black : Color.gray, lineWidth: 1))
        }
        .foregroundColor(isSelected ? .black : .gray)
    }
}

struct SubtotalView: View {
    let subtotal: Int
    let total: Int
    
    var body: some View {
        VStack {
            HStack {
                Text("Subtotal")
                Spacer()
                Text("Rp\(subtotal)")
            }
            HStack {
                Text("Total")
                    .fontWeight(.bold)
                Spacer()
                Text("Rp\(total)")
                    .fontWeight(.bold)
            }
        }
    }
}

struct PayButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text("Pay")
                .frame(maxWidth: .infinity)
                .padding()
                .background(LinearGradient(colors: [.gray, .black], startPoint: .bottomLeading, endPoint: .topTrailing))
                .foregroundColor(.white)
                .cornerRadius(15)
        }
    }
}


struct ShippingOptionsView: View {
    let methods: [ShippingMethod]
    let selectedMethod: ShippingMethod?
    let selectMethod: (ShippingMethod) -> Void
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            List(methods) { method in
                Button(action: {
                    selectMethod(method)
                    presentationMode.wrappedValue.dismiss()
                }) {
                    ShippingMethodRow(method: method)
                        .background(method.id == selectedMethod?.id ? Color.blue.opacity(0.1) : Color.clear)
                }
            }
            .navigationBarTitle("Select Shipping", displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}


struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(cartItems: sampleCartItems)
    }
    
    static var sampleCartItems: [CartItem] = [
        CartItem(id: UUID(), name: "Modern Chair", price: 750000, quantity: 1, imageName: "chair1", isSelected: true, isFavorite: false),
        CartItem(id: UUID(), name: "Wooden Table", price: 1200000, quantity: 1, imageName: "table1", isSelected: true, isFavorite: true),
        CartItem(id: UUID(), name: "Floor Lamp", price: 300000, quantity: 2, imageName: "lamp1", isSelected: true, isFavorite: false)
    ]
}
