//
//  TransactionHistoryViewModel.swift
//  furniture-finalproject
//
//  Created by andra-dev on 19/08/24.
//

import SwiftUI

class TransactionHistoryViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    
    func addTransaction(_ transaction: Transaction) {
            transactions.insert(transaction, at: 0)
            print("Transaction added. Total transactions: \(transactions.count)")
            print("Latest transaction: \(transaction)")
    }
}
