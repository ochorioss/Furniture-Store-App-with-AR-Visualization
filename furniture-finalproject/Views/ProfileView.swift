//
//  ProfileView.swift
//  furniture-finalproject
//
//  Created by andra-dev on 15/08/24.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var viewModel: ProfileViewModel
    @EnvironmentObject private var transactionHistoryViewModel: TransactionHistoryViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
       
    var body: some View {
        VStack(spacing: 50) {
            // Profile Picture
            Button(action: {
                viewModel.isShowingImagePicker = true
            }) {
                ProfilePicture(image: viewModel.profileImage, user: authViewModel.currentUser, size: 200)
            }
            .sheet(isPresented: $viewModel.isShowingImagePicker) {
                    ImagePicker(image: $viewModel.profileImage, onImagePicked: { image in
                    viewModel.saveProfileImage(image)
                })
            }
            
            // User Name
            Text(authViewModel.currentUser?.fullName ?? "User")
                .font(.title2)
                .fontWeight(.bold)
            
            // Navigation Buttons
            VStack(spacing: 10) {
                NavigationLink(destination: AccountInformationView()) {
                    ProfileButtonView(title: "Account Information")
                }
                
                NavigationLink(destination: TransactionHistoryView()) {
                    ProfileButtonView(title: "Transaction History")
                }
                
                NavigationLink(destination: WishlistView()) {
                    ProfileButtonView(title: "Wishlist")
                }
            }
            
            // Sign Out Button
            Button(action: {
                authViewModel.signOut()
            }) {
                Text("Sign Out")
                    .foregroundColor(.red)
                    .font(.headline)
            }
        }
        .padding()
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.updateUserName()
            viewModel.loadProfileImage()
        }
    }
}

struct ProfileButtonView: View {
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.primary)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) private var presentationMode
    let onImagePicked: (UIImage) -> Void
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.image = image
                parent.onImagePicked(image)
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView()
                .environmentObject(TransactionHistoryViewModel())
                .environmentObject(AuthViewModel())
        }
    }
}
