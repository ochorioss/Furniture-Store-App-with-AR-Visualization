//
//  LoginView.swift
//  furniture-finalproject
//
//  Created by andra-dev on 18/08/24.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var showingAlert = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Login")
                .font(.title)
                .fontWeight(.bold)
            
            TextField("Email", text: $email)
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
                .textFieldStyle(.roundedBorder)
            
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
            
            Button(action: {
                if authViewModel.login(email: email, password: password) {
                    // Login successful, navigate to main app view
                } else {
                    showingAlert = true
                }
            }) {
                Text("Login")
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(LinearGradient(colors: [.gray, .black], startPoint: .bottomLeading, endPoint: .topTrailing))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 2, x: 0.0 , y: 2)
            }
            
            NavigationLink("Don't have an account? Click here to register", destination: RegisterView())
                .font(.footnote)
                .foregroundStyle(.blue)
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Login Failed"), message: Text(authViewModel.error ?? "Unknown error"), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    NavigationStack {
        LoginView()
            .environmentObject(AuthViewModel())
    }
}
