//
//  ProductDetailViewModel.swift
//  furniture-finalproject
//
//  Created by andra-dev on 18/08/24.
//

//import Foundation
//import FirebaseFirestore
//
//class ProductDetailViewModel: ObservableObject {
//    @Published var product: Product
//    @Published var errorMessage: String?
//    @Published var isFavorite: Bool = false
//
//    private var db = Firestore.firestore()
//
//    init(product: Product) {
//        self.product = product
//    }
//
//    func updateProduct() {
//        if let id = product.id {
//            do {
//                try db.collection("products").document(id).setData(from: product)
//            } catch let error {
//                self.errorMessage = "Error updating product: \(error.localizedDescription)"
//            }
//        }
//    }
//}
