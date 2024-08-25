//
//  WelcomeView.swift
//  furniture-finalproject
//
//  Created by andra-dev on 18/08/24.
//

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background Image
                Image("furniture_background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 8) {
                    Spacer()
                    
                    Text("Welcome,")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    
                    Text("to the place where your dream furniture came true")
                        .font(.headline)
                        .fontWeight(.light)
                        .foregroundStyle(.white)
                    
                    NavigationLink(destination: LoginView()) {
                        Text("Get Started")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(LinearGradient(colors: [.gray, .black], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .shadow(radius: 2, x: 0.0 , y: 2)
                    }
                    .padding(.top, 30)
                }
                .padding(30)
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    WelcomeView()
        .environmentObject(AuthViewModel())
}
