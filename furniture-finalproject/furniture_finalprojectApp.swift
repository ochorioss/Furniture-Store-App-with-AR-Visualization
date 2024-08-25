//
//  furniture_finalprojectApp.swift
//  furniture-finalproject
//
//  Created by andra-dev on 15/08/24.
//

import SwiftUI

@main
struct furniture_finalprojectApp: App {
    @StateObject private var authViewModel = AuthViewModel()
    @StateObject private var cartViewModel = CartViewModel()
    @StateObject private var transactionHistoryViewModel = TransactionHistoryViewModel()
    @StateObject private var profileViewModel = ProfileViewModel(authViewModel: AuthViewModel())

    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(authViewModel)
                .environmentObject(cartViewModel)
                .environmentObject(transactionHistoryViewModel)
                .environmentObject(WishlistViewModel())
                .environmentObject(profileViewModel)
        }
    }
}
