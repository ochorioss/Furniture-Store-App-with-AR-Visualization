//
//  CategoryDetailView.swift
//  furniture-finalproject
//
//  Created by andra-dev on 15/08/24.
//

import SwiftUI

struct CategoryDetailView: View {
    @StateObject private var viewModel: CategoryDetailViewModel
    
    let columns = [
        GridItem(.fixed(150), spacing: 15),
        GridItem(.fixed(150), spacing: 15)
    ]
    
    init(category: Category) {
        _viewModel = StateObject(wrappedValue: CategoryDetailViewModel(category: category))
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                if let featuredItem = viewModel.featuredItems.first {
                    FeaturedCategoryBanner(item: featuredItem)
                }
                
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(viewModel.categoryItems) { item in
                        CategoryItemView(item: item)
                    }
                }
                .padding(.horizontal, 10)
            }
            .padding()
        }
        .padding(.top, 4)
        .navigationTitle(viewModel.category.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.loadCategoryItems()
        }
    }
}

struct FeaturedCategoryBanner: View {
    let item: Product
    
    var body: some View {
        ZStack(alignment: .center) {
            Image(item.bannerImageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 335, height: 210)
                .clipped()
            
            VStack(alignment: .leading, spacing: 8) {
                Text(item.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text(item.description)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
            }
            .padding(.top, 28)
            .padding(.leading, 28)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .frame(width: 330, height: 210)
        .cornerRadius(10)
    }
}

struct CategoryItemView: View {
    let item: Product
    
    var body: some View {
        NavigationLink(destination: ProductDetailView(item: item)) {
            VStack(alignment: .leading, spacing: 4) {
                Image(item.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)
                    .clipped()
                    .cornerRadius(10)
                
                Text(item.name)
                    .font(.system(size: 16, weight: .semibold))
                    .lineLimit(1)
                    .foregroundColor(.primary)
                
                Text("Rp\(formatPrice(item.price))")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.black)
                
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.system(size: 12))
                    Text(String(format: "%.1f", item.rating))
                        .font(.system(size: 12))
                        .foregroundStyle(Color.black)
                    Text("\(item.soldCount) Sold")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal, 4)
            .frame(width: 150, height: 200)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 2)
        }
    }
    
    private func formatPrice(_ price: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        return formatter.string(from: NSNumber(value: price)) ?? "\(price)"
    }
}

struct CategoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CategoryDetailView(category: Category(name: "Drawer", imageName: "drawer"))
        }
    }
}
