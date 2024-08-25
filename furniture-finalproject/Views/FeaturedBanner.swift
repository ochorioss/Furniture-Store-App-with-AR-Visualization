//
//  FeaturedBanner.swift
//  furniture-finalproject
//
//  Created by andra-dev on 15/08/24.
//

import SwiftUI

struct FeaturedBanner: View {
    @State private var currentPage = 0
    let bannerContents: [BannerContent]
    
    var body: some View {
        VStack(spacing: 12) {
            TabView(selection: $currentPage) {
                ForEach(0..<bannerContents.count, id: \.self) { index in
                    BannerView(content: bannerContents[index])
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(height: 180)
            .cornerRadius(10)
            
            HStack(spacing: 8) {
                ForEach(0..<bannerContents.count, id: \.self) { index in
                    Circle()
                        .fill(currentPage == index ? Color.black : Color.gray)
                        .frame(width: 8, height: 8)
                }
            } 
        }
    }
}

struct BannerView: View {
    let content: BannerContent
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Image(content.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(content.title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text(content.subtitle)
                    .font(.subheadline)
                    .foregroundColor(.white)
            }
            .padding(.top, 32)
            .padding(.horizontal, 28)
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    FeaturedBanner(bannerContents: [
        BannerContent(imageName: "featured_banner", title: "Comfort and Stylish", subtitle: "Improve your satisfaction\nwith our products"),
        BannerContent(imageName: "featured_banner1", title: "Modern Design", subtitle: "Elevate your space with\ncontemporary furniture"),
        BannerContent(imageName: "featured_banner2", title: "Quality Craftsmanship", subtitle: "Durable pieces built\nto last a lifetime"),
        BannerContent(imageName: "featured_banner3", title: "Eco-Friendly Options", subtitle: "Sustainable choices for\na greener home")
    ])
}
