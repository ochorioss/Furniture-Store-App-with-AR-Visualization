//
//  AuthViewModel.swift
//  furniture-finalproject
//
//  Created by andra-dev on 18/08/24.
//

import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var currentUser: User?
    @Published var error: String?
    
    private let userDefaults = UserDefaults.standard
    
    init() {
        
        self.isLoggedIn = userDefaults.bool(forKey: "isLoggedIn")
        print("DEBUG: Init - isLoggedIn: \(self.isLoggedIn)")
        if isLoggedIn {
            loadCurrentUser()
        }
        
    }
    
    func register(email: String, password: String, firstName: String, lastName: String, phoneNumber: String) -> Bool {
        // Check if email is already registered
        if userDefaults.object(forKey: "user_\(email)") != nil {
            self.error = "Email already registered"
            return false
        }
        
        // Create new user
        let newUser = User(firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber)
        
        // Encode user data
        if let encoded = try? JSONEncoder().encode(newUser) {
            // Store user data
            userDefaults.set(encoded, forKey: "user_\(email)")
            // Store password (Note: In a real app, you should hash passwords)
            userDefaults.set(password, forKey: "password_\(email)")
            
            // Set current user and login state
            self.currentUser = newUser
            self.isLoggedIn = true
            userDefaults.set(true, forKey: "isLoggedIn")
            userDefaults.set(email, forKey: "currentUserEmail")
            
            return true
        } else {
            self.error = "Failed to save user data"
            return false
        }
    }
    
    func login(email: String, password: String) -> Bool {
        guard let storedPassword = userDefaults.string(forKey: "password_\(email)"),
              storedPassword == password else {
            self.error = "Invalid email or password"
            return false
        }
        
        loadCurrentUser()
        isLoggedIn = true
        userDefaults.set(true, forKey: "isLoggedIn")
        userDefaults.set(email, forKey: "currentUserEmail")
        return true
    }
    
    func updateUserInformation(firstName: String, lastName: String, email: String, phoneNumber: String) -> Bool {
        guard var updatedUser = currentUser else { return false }
        
        updatedUser.firstName = firstName
        updatedUser.lastName = lastName
        updatedUser.email = email
        updatedUser.phoneNumber = phoneNumber
        
        if let encoded = try? JSONEncoder().encode(updatedUser) {
            userDefaults.set(encoded, forKey: "user_\(email)")
            currentUser = updatedUser
            return true
        } else {
            error = "Failed to update user information"
            return false
        }
    }
    
    func signOut() {
        isLoggedIn = false
        currentUser = nil
        userDefaults.set(false, forKey: "isLoggedIn")
        userDefaults.removeObject(forKey: "currentUserEmail")
    }
    
    func updateUserProfileImage(_ imageData: Data) {
        guard var updatedUser = currentUser else { return }
        updatedUser.profileImageData = imageData
        if let encoded = try? JSONEncoder().encode(updatedUser) {
            userDefaults.set(encoded, forKey: "user_\(updatedUser.email)")
            DispatchQueue.main.async {
                self.currentUser = updatedUser
            }
        }
    }
    
    func loadCurrentUser() {
        guard let email = userDefaults.string(forKey: "currentUserEmail"),
              let userData = userDefaults.data(forKey: "user_\(email)"),
              let user = try? JSONDecoder().decode(User.self, from: userData) else {
            return
        }
        DispatchQueue.main.async {
            self.currentUser = user
        }
    }
}
