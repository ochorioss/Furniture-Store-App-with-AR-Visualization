//
//  RegisterView.swift
//  furniture-finalproject
//
//  Created by andra-dev on 18/08/24.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var phoneNumber = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Register")
                .font(.title)
                .fontWeight(.bold)
            
            TextField("First Name", text: $firstName)
                .textFieldStyle(.roundedBorder)
            
            TextField("Last Name", text: $lastName)
                .textFieldStyle(.roundedBorder)
            
            TextField("Email", text: $email)
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
                .textFieldStyle(.roundedBorder)
            
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
            
            TextField("Phone Number", text: $phoneNumber)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.phonePad)
            
            Button(action: {
                if authViewModel.register(email: email, password: password, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber) {
                    alertMessage = "Registration successful!"
                    showingAlert = true
                } else {
                    alertMessage = authViewModel.error ?? "Registration failed"
                    showingAlert = true
                }
            }) {
                Text("Register")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(LinearGradient(colors: [.gray, .black], startPoint: .bottomLeading, endPoint: .topTrailing))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Registration"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    NavigationStack {
        RegisterView()
            .environmentObject(AuthViewModel())
    }
}
