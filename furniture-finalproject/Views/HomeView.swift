//
//  HomeView.swift
//  furniture-finalproject
//
//  Created by andra-dev on 15/08/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @EnvironmentObject private var authViewModel: AuthViewModel
    @EnvironmentObject private var profileViewModel: ProfileViewModel
    
    
    var body: some View {
        VStack(spacing: 52) {
            HStack {
                searchBar(text: $viewModel.searchText)
                NavigationLink(destination: ProfileView()) {
                    ProfilePicture(image: profileViewModel.profileImage, user: authViewModel.currentUser, size: 44)
                }
            }
            .padding(.horizontal)
            
            FeaturedBanner(bannerContents: viewModel.bannerContents)
                .frame(height: 150)
            
            customCategoryGrid
                
            
            Spacer()
        }
        .navigationBarHidden(true)
        .padding(.top, 16)
    }
    
    var customCategoryGrid: some View {
        ScrollView {
            Spacer()
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                ForEach(viewModel.filteredCategories) { category in
                    CategoryButton(category: category, width: 160, height: 152)
                }
            }
            .padding(.horizontal)
        }
    }
    
    struct searchBar: View {
        @Binding var text: String
        var body: some View {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(Color.gray)
                
                TextField("Search Here", text: $text)
            }
            .padding(10)
            .background(Color(.systemGray6))
            .cornerRadius(10)
        }
    }
    
    struct CategoryButton: View {
        let category: Category
        let width: CGFloat
        let height: CGFloat
        
        var body: some View {
            NavigationLink(destination: CategoryDetailView(category: category)) {
                VStack {
                    Image(category.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: height * 0.6)
                    
                    Text(category.name)
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                }
                .frame(width: width, height: height)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 2)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .environmentObject(AuthViewModel())
                .environmentObject(ProfileViewModel(authViewModel: AuthViewModel()))
        }
    }
}
