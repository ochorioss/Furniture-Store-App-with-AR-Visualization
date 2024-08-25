//
//  CustomAlertView.swift
//  furniture-finalproject
//
//  Created by andra-dev on 19/08/24.
//

import SwiftUI

struct CustomAlertView: View {
    let title: String
    let message: String
    @Binding var isPresented: Bool
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 15) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.black)
                
                Text(message)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 40))
                    .foregroundStyle(LinearGradient(colors: [.gray, .black], startPoint: .bottomLeading, endPoint: .topTrailing))
            }
            .padding()
            .frame(width: geometry.size.width * 0.8)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 10)
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
        }
        .background(Color.black.opacity(0.4))
        .edgesIgnoringSafeArea(.all)
    }
}

struct CustomAlertView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ZStack {
                Color.gray.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                
                CustomAlertView(
                    title: "Added to Cart",
                    message: "Your item has been added to the cart.",
                    isPresented: .constant(true)
                )
            }
            .previewDisplayName("Standard Alert")
            
            ZStack {
                Color.gray.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                
                CustomAlertView(
                    title: "Error",
                    message: "Unable to add item to cart. Please try again.",
                    isPresented: .constant(true)
                )
            }
            .previewDisplayName("Error Alert")
        }
    }
}

//

