//
//  Products.swift
//  furniture-finalproject
//
//  Created by andra-dev on 20/08/24.
//

import Foundation
import SwiftUI

struct Product: Identifiable {
    let id: UUID
    let name: String
    let description: String
    let price: Int
    let rating: Double
    let soldCount: Int
    let imageName: String
    let bannerImageName: String
    let modelName: String
    
    init(id: UUID = UUID(), name: String, description: String, price: Int, rating: Double, soldCount: Int, imageName: String, bannerImageName: String, modelName: String) {
        self.id = id
        self.name = name
        self.description = description
        self.price = price
        self.rating = rating
        self.soldCount = soldCount
        self.imageName = imageName
        self.bannerImageName = bannerImageName
        self.modelName = modelName
    }
}
