//
//  AccountInformationView.swift
//  furniture-finalproject
//
//  Created by andra-dev on 15/08/24.
//

import SwiftUI

struct AccountInformationView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var phoneNumber: String = ""
    @State private var isEditing: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Custom Navigation Bar
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.primary)
                }
                
                Spacer()
                
                Text("Account Information")
                    .font(.headline)
                
                Spacer()
                
                Button(isEditing ? "Save" : "Edit") {
                    if isEditing {
                        saveChanges()
                    }
                    isEditing.toggle()
                } .foregroundStyle(.black)
            }
            .padding()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    AccountInfoField(title: "First Name", value: $firstName, isEditing: isEditing)
                    AccountInfoField(title: "Last Name", value: $lastName, isEditing: isEditing)
                    AccountInfoField(title: "Email", value: $email, isEditing: isEditing)
                    AccountInfoField(title: "Phone Number", value: $phoneNumber, isEditing: isEditing)
                }
                .padding()
            }
        }
        .navigationBarHidden(true)
        .onAppear(perform: loadUserData)
    }
    
    private func loadUserData() {
        guard let user = authViewModel.currentUser else { return }
        firstName = user.firstName
        lastName = user.lastName
        email = user.email
        phoneNumber = user.phoneNumber
    }
    
    private func saveChanges() {
        authViewModel.updateUserInformation(firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber)
    }
}

struct AccountInfoField: View {
    let title: String
    @Binding var value: String
    let isEditing: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            if isEditing {
                TextField(title, text: $value)
                    .textFieldStyle(PlainTextFieldStyle())
            } else {
                Text(value)
                    .font(.body)
            }
            
            Divider()
        }
    }
}

struct AccountInformationView_Previews: PreviewProvider {
    static var previews: some View {
        AccountInformationView()
            .environmentObject(AuthViewModel())
    }
}
