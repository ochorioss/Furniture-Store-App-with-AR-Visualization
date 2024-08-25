//
//  BuyNowView.swift
//  furniture-finalproject
//
//  Created by andra-dev on 19/08/24.
//

// BuyNowView.swift

import SwiftUI

struct BuyNowView: View {
    @StateObject private var viewModel: BuyNowViewModel
    @EnvironmentObject var transactionHistoryViewModel : TransactionHistoryViewModel
    @State private var showShippingOptions = false
    @Environment(\.presentationMode) var presentationMode
    

    init(item: Product) {
        _viewModel = StateObject(wrappedValue: BuyNowViewModel(item: item, transactionHistoryViewModel: TransactionHistoryViewModel())
        )
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                NavigationBar(action: { presentationMode.wrappedValue.dismiss() })
                
                ShippingAddressView(address: viewModel.selectedAddress)
                
                BuyNowItemView(item: viewModel.item, quantity: $viewModel.quantity)
                
                ShippingMethodView(
                    selectedMethod: viewModel.selectedShippingMethod,
                    showOptions: $showShippingOptions
                )
                
                PaymentMethodView(selectedMethod: $viewModel.selectedPaymentMethod)
                
                SubtotalView(subtotal: viewModel.subtotal, total: viewModel.total)
                
                BuyNowButton(action: viewModel.processBuyNow)
            }
            .padding()
        }
        .onAppear{
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

struct BuyNowItemView: View {
    let item: Product
    @Binding var quantity: Int
    
    var body: some View {
        HStack(spacing: 16) {
            Image(item.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .font(.headline)
                Text("Rp\(item.price)")
                    .font(.subheadline)
                
                Stepper("Quantity: \(quantity)", value: $quantity, in: 1...10)
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
    }
}

struct BuyNowButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text("Buy Now")
                .frame(maxWidth: .infinity)
                .padding()
                .background(LinearGradient(colors: [.gray, .black], startPoint: .bottomLeading, endPoint: .topTrailing))
                .foregroundColor(.white)
                .cornerRadius(15)
        }
    }
}

// Note: Reuse ShippingAddressView, ShippingMethodView, PaymentMethodView, and SubtotalView from your existing CheckoutView

struct BuyNowView_Previews: PreviewProvider {
    static var previews: some View {
        BuyNowView(item: Product(name: "Sample Item", description: "A sample item", price: 1000000, rating: 4.5, soldCount: 100, imageName: "sample_image", bannerImageName: "", modelName: ""))
    }
}
