//
//  ProductService.swift
//  furniture-finalproject
//
//  Created by andra-dev on 21/08/24.
//

import Firebase
import FirebaseFirestore
import FirebaseStorage

class ProductService: ObservableObject {
    private var db = Firestore.firestore()
    private var storage = Storage.storage()
    
    func fetchProducts(completion: @escaping ([Product]) -> Void) {
        db.collection("products").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching products: \(error)")
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("No documents found")
                return
            }
            
            let products = documents.compactMap { document -> Product? in
                try? document.data(as: Product.self)
            }
            
            completion(products)
        }
    }
    
    func fetchImageURL(for imageName: String, completion: @escaping (URL?) -> Void) {
        let storageRef = storage.reference().child("product_images/\(imageName)")
        storageRef.downloadURL { url, error in
            if let error = error {
                print("Error fetching image URL: \(error)")
                completion(nil)
            } else {
                completion(url)
            }
        }
    }
    
    func fetchUSPZURL(for modelName: String, completion: @escaping (URL?) -> Void) {
        let storageRef = storage.reference().child("3d_models/\(modelName)")
        storageRef.downloadURL { url, error in
            if let error = error {
                print("Error fetching USDZ URL: \(error)")
                completion(nil)
            } else {
                completion(url)
            }
        }
    }
}
