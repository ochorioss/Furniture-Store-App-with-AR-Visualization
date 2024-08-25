//
//  CheckoutViewModel.swift
//  furniture-finalproject
//
//  Created by andra-dev on 19/08/24.
//

import SwiftUI
import Combine

class CheckoutViewModel: ObservableObject {
    @Published var cartItems: [CartItem] = []
    @Published var selectedAddress: Address?
    @Published var shippingMethods: [ShippingMethod] = []
    @Published var selectedShippingMethod: ShippingMethod?
    @Published var selectedPaymentMethod: PaymentMethod?
    @Published var subtotal: Int = 0
    @Published var total: Int = 0
    @Published var showSuccessAlert = false

    private var cancellables = Set<AnyCancellable>()
    
    private var transactionHistoryViewModel: TransactionHistoryViewModel?
       
    init(cartItems: [CartItem], transactionHistoryViewModel: TransactionHistoryViewModel) {
        self.cartItems = cartItems
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
        $cartItems.combineLatest($selectedShippingMethod)
            .map { (items, shipping) in
                let itemsTotal = items.reduce(0) { $0 + $1.price * $1.quantity }
                let shippingCost = shipping?.price ?? 0
                return (itemsTotal, itemsTotal + shippingCost)
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
    
    func processPayment() {
            guard let shippingMethod = selectedShippingMethod,
                  let paymentMethod = selectedPaymentMethod else {
                print("Shipping or payment method not selected")
                return
            }
            
            let purchasedItems = cartItems.map { item in
                PurchasedItem(id: UUID(), name: item.name, price: item.price, quantity: item.quantity, imageName: item.imageName)
            }
            
            let transaction = Transaction(
                id: UUID(),
                date: Date(),
                items: purchasedItems,
                total: total,
                shippingMethod: shippingMethod,
                paymentMethod: paymentMethod
            )
            
            transactionHistoryViewModel?.addTransaction(transaction)
            showSuccessAlert = true
    }
}
