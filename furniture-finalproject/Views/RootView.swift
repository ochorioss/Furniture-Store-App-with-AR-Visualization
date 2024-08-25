//
//  RootView.swift
//  furniture-finalproject
//
//  Created by andra-dev on 20/08/24.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        Group {
            if authViewModel.isLoggedIn {
                MainTabView()
            } else {
                WelcomeView()
            }
        }
    }
}
