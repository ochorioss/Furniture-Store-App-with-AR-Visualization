//
//  ProfilePicture.swift
//  furniture-finalproject
//
//  Created by andra-dev on 21/08/24.
//

import SwiftUI

struct ProfilePicture: View {
    let image: UIImage?
    let user: User?
    let size: CGFloat
    
    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else if let imageData = user?.profileImageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
            }
        }
        .frame(width: size, height: size)
        .clipShape(Circle())
    }
}
