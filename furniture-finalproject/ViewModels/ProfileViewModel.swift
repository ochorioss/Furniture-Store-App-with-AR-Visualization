//
//  ProfileViewModel.swift
//  furniture-finalproject
//
//  Created by andra-dev on 15/08/24.
//
import SwiftUI
import Foundation

class ProfileViewModel: ObservableObject {
    @Published var profileImage: UIImage?
    @Published var isShowingImagePicker = false
    @Published var userName: String
    
    private let authViewModel: AuthViewModel
    
    init(authViewModel: AuthViewModel) {
        self.authViewModel = authViewModel
        self.userName = authViewModel.currentUser?.fullName ?? "User"
        loadProfileImage()
    }
    
    func signOut() {
        authViewModel.signOut()
    }
    
    func updateUserName() {
        userName = authViewModel.currentUser?.fullName ?? "User"
    }
    
    func loadProfileImage() {
        if let imageData = authViewModel.currentUser?.profileImageData,
           let image = UIImage(data: imageData) {
            self.profileImage = image
        }
    }
    
    func saveProfileImage(_ image: UIImage) {
        if let imageData = image.jpegData(compressionQuality: 0.8) {
            authViewModel.updateUserProfileImage(imageData)
            DispatchQueue.main.async {
                self.profileImage = image
            }
        }
    }
}
