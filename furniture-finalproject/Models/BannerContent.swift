//
//  BannerContent.swift
//  furniture-finalproject
//
//  Created by andra-dev on 20/08/24.
//

import Foundation

struct BannerContent: Identifiable, Hashable {
    let id: UUID
    let imageName: String
    let title: String
    let subtitle: String
    
    init(id: UUID = UUID(), imageName: String, title: String, subtitle: String) {
        self.id = id
        self.imageName = imageName
        self.title = title
        self.subtitle = subtitle
    }
}
