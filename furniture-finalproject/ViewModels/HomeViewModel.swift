//
//  HomeViewModel.swift
//  furniture-finalproject
//
//  Created by andra-dev on 15/08/24.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var bannerContents: [BannerContent] = [
        BannerContent(imageName: "featured_banner", title: "Comfort and Stylish", subtitle: "Improve your satisfaction\nwith our products"),
        BannerContent(imageName: "featured_banner1", title: "Modern Design", subtitle: "Elevate your space with\ncontemporary furniture"),
        BannerContent(imageName: "featured_banner2", title: "Quality Craftsmanship", subtitle: "Durable pieces built\nto last a lifetime"),
        BannerContent(imageName: "featured_banner3", title: "Eco-Friendly Options", subtitle: "Sustainable choices for\na greener home")
    ]
    @Published var categories: [Category] = [
        Category(name: "Drawer", imageName: "drawer1"),
        Category(name: "Decoration", imageName: "decor3"),
        Category(name: "Table", imageName: "table1"),
        Category(name: "Chair", imageName: "chair4")
    ]
    
    var filteredCategories: [Category] {
           if searchText.isEmpty {
               return categories
           } else {
               return categories.filter { $0.name.lowercased().contains(searchText.lowercased()) }
           }
       }
}
