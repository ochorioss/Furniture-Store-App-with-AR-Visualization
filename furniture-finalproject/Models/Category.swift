//
//  Category.swift
//  furniture-finalproject
//
//  Created by andra-dev on 19/08/24.
//

import Foundation

struct Category: Identifiable, Hashable {
    let id: UUID
    let name: String
    let imageName: String
    
    init(id: UUID = UUID(), name: String, imageName: String){
        self.id = id
        self.name = name
        self.imageName = imageName
    }
}
