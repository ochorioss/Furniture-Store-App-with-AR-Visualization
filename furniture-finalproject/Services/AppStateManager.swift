//
//  AppStateManager.swift
//  furniture-finalproject
//
//  Created by andra-dev on 20/08/24.
//

import SwiftUI

class AppStateManager: ObservableObject {
    @Published var currentView: AppView = .welcome
    
    enum AppView {
        case welcome
        case main
    }
    
    func signIn() {
        currentView = .main
    }
    
    func signOut() {
        currentView = .welcome
    }
}
