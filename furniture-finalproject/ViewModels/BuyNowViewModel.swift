//
//  BuyNowViewModel.swift
//  furniture-finalproject
//
//  Created by andra-dev on 19/08/24.
//

import SwiftUI
import Combine

class BuyNowViewModel: ObservableObject {
    @Published var item: Product
    @Published var quantity: Int = 1
    @Published var selectedAddress: Address?
    @Published var shippingMethods: [ShippingMethod] = []
    @Published var selectedShippingMethod: ShippingMethod?
    @Published var selectedPaymentMethod: PaymentMethod?
    @Published var subtotal: Int = 0
    @Published var total: Int = 0
    
    @Published var showSuccessAlert = false

    private var cancellables = Set<AnyCancellable>()
    
    private var transactionHistoryViewModel: TransactionHistoryViewModel?
    
    init(item: Product, transactionHistoryViewModel: TransactionHistoryViewModel) {
        self.item = item
        self.transactionHistoryViewModel = transactionHistoryViewModel
        setupInitialData()
        setupCalculations()
    }

    private func setupInitialData() {
        // Sample data (replace with actual data fetching logic)
        selectedAddress = Address(type: "Home", street: "Jl. Chumad II No. 99, Pasar Minggu", city: "Jakarta Selatan, DKI Jakarta, Indonesia", name: "Lovina", phone: "+62 87600996612")

        shippingMethods = [
            ShippingMethod(name: "Free", estimatedDelivery: "Estimated arrival 11 - 20 august", price: 0),
            ShippingMethod(name: "Regular", estimatedDelivery: "Estimated arrival 10 - 15 august", price: 150000),
            ShippingMethod(name: "Express", estimatedDelivery: "Estimated arrival 9 - 11 august", price: 350000)
        ]
    }

    private func setupCalculations() {
        Publishers.CombineLatest3($item, $quantity, $selectedShippingMethod)
            .map { (item, quantity, shipping) in
                let itemTotal = item.price * quantity
                let shippingCost = shipping?.price ?? 0
                return (itemTotal, itemTotal + shippingCost)
            }
            .sink { [weak self] (subtotal, total) in
                self?.subtotal = subtotal
                self?.total = total
            }
            .store(in: &cancellables)
    }

    func selectShippingMethod(_ method: ShippingMethod) {
        selectedShippingMethod = method
    }

    func selectPaymentMethod(_ method: PaymentMethod) {
        selectedPaymentMethod = method
    }
    
    func setTransactionHistoryViewModel(_ viewModel: TransactionHistoryViewModel) {
            self.transactionHistoryViewModel = viewModel
        }

    func processBuyNow() {
            guard let shippingMethod = selectedShippingMethod,
                  let paymentMethod = selectedPaymentMethod else {
                print("Shipping or payment method not selected")
                return
            }
            
            let purchasedItem = PurchasedItem(id: UUID(), name: item.name, price: item.price, quantity: quantity, imageName: item.imageName)
            
            let transaction = Transaction(
                id: UUID(),
                date: Date(),
                items: [purchasedItem],
                total: total,
                shippingMethod: shippingMethod,
                paymentMethod: paymentMethod
            )
            
            transactionHistoryViewModel?.addTransaction(transaction)
            showSuccessAlert = true
    }
}
