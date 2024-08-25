////
////  ARInstructionsView.swift
////  furniture-finalproject
////
////  Created by andra-dev on 19/08/24.
////
//
import SwiftUI

struct ARInstructionsView: View {
    let item: Product
    @Environment(\.presentationMode) var presentationMode
    @State private var showARExperience = false
    @StateObject private var viewModel = ARViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("AR Furniture Viewer")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Image(systemName: "arkit")
                .font(.system(size: 100))
                .foregroundColor(.black)
            
            VStack(alignment: .leading, spacing: 15) {
                InstructionRow(number: 1, text: "Find a clear, well-lit space")
                InstructionRow(number: 2, text: "Point your camera at the floor")
                InstructionRow(number: 3, text: "Tap to place \(item.name) in AR")
                InstructionRow(number: 4, text: "Pinch to resize the model")
                InstructionRow(number: 5, text: "Drag to move the model")
                InstructionRow(number: 6, text: "Rotate with two fingers to turn the model")
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            
            Button(action: {
                showARExperience = true
            }) {
                Text("Start AR Experience")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(LinearGradient(colors: [.gray, .black], startPoint: .bottomLeading, endPoint: .topTrailing))
                    .cornerRadius(10)
            }
            .padding(.top)
        }
        .padding()
        .fullScreenCover(isPresented: $showARExperience) {
            ARViewContainer(viewModel: viewModel ,item: item)
        }
    }
}

struct InstructionRow: View {
    let number: Int
    let text: String
    
    var body: some View {
        HStack(spacing: 15) {
            Text("\(number)")
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: 30, height: 30)
                .background(Color.black)
                .clipShape(Circle())
            
            Text(text)
                .font(.body)
        }
    }
}

#Preview {
    ARInstructionsView(item: Product(
        name: "Sample Furniture",
        description: "This is a sample furniture item.",
        price: 1000000,
        rating: 4.5,
        soldCount: 100,
        imageName: "sample_furniture",
        bannerImageName: "sample_banner",
        modelName: ""
    ))
}
