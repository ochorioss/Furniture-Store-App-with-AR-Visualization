//
//  TranscationHistoryView.swift
//  furniture-finalproject
//
//  Created by andra-dev on 15/08/24.
//

// TransactionHistoryView.swift

import SwiftUI

struct TransactionHistoryView: View {
    @EnvironmentObject var viewModel: TransactionHistoryViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Group {
                   if viewModel.transactions.isEmpty {
                       emptyStateView
                   } else {
                       transactionListView
                   }
               }
               .navigationBarHidden(true)
    }

    private var emptyStateView: some View {
        VStack (spacing: 0) {
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
                    
                    Text("Transaction History")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.primary)
                }
                .frame(height: 44)
                
                Spacer()
                Text("No transactions yet")
                    .font(.headline)
                Text("Your transaction history will appear here")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Spacer()
            }
        }

    private var transactionListView: some View {
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
                
                Text("Transaction History")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.primary)
            }
            .frame(height: 44)
          
            
            // Transaction List
            List(viewModel.transactions) { transaction in
                TransactionRow(transaction: transaction)
            }
            .listStyle(PlainListStyle())
        }
    }
}

struct TransactionRow: View {
    let transaction: Transaction
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(transaction.date, style: .date)
                .font(.headline)
            
            ForEach(transaction.items) { item in
                HStack {
                    Image(item.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                    
                    VStack(alignment: .leading) {
                        Text(item.name)
                        Text("Quantity: \(item.quantity)")
                            .font(.caption)
                    }
                    
                    Spacer()
                    
                    Text("Rp\(item.price * item.quantity)")
                }
            }
            
            HStack {
                Text("Total:")
                Spacer()
                Text("Rp\(transaction.total)")
                    .fontWeight(.bold)
            }
            
            Text("Shipping: \(transaction.shippingMethod.name)")
            Text("Payment: \(transaction.paymentMethod.rawValue)")
        }
        .padding(.vertical)
    }
}

struct TransactionHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = TransactionHistoryViewModel()
        viewModel.addTransaction(Transaction(
            id: UUID(),
            date: Date(),
            items: [PurchasedItem(id: UUID(), name: "Sample Item", price: 1000000, quantity: 2, imageName: "drawer1")],
            total: 2150000,
            shippingMethod: ShippingMethod(name: "Express", estimatedDelivery: "Estimated arrival 9 - 11 august", price: 150000),
            paymentMethod: .creditCard
        ))
        
        return NavigationView {
            TransactionHistoryView()
                .environmentObject(viewModel)
        }
    }
}
