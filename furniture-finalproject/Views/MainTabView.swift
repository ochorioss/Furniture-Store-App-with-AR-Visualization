//
//  MainTabView.swift
//  furniture-finalproject
//
//  Created by andra-dev on 15/08/24.
//

import SwiftUI

struct MainTabView: View {
    @StateObject private var authViewModel = AuthViewModel()
    @StateObject private var wishlistViewModel = WishlistViewModel()
    @State private var selectedTab = 0
    @EnvironmentObject private var profileViewModel: ProfileViewModel
    @StateObject private var cartViewModel = CartViewModel()
    
    
    var body: some View {
        GeometryReader { geometry in
                    ZStack(alignment: .bottom) {
                        TabView(selection: $selectedTab) {
                            NavigationStack {
                                HomeView()
                            }
                            .tag(0)
                            
                            NavigationStack {
                                CartView()
                            }
                            .tag(1)
                            
                            NavigationStack {
                                ProfileView()
                            }
                            .tag(2)
                        }
                        
                        CustomTabBar(selectedTab: $selectedTab, geometry: geometry)
                    }
                    .edgesIgnoringSafeArea(.bottom)
                }
                .environmentObject(profileViewModel)
                .environmentObject(cartViewModel)
                .environmentObject(authViewModel)
                .environmentObject(wishlistViewModel)
            }
}

struct CustomTabBar: View {
    @Binding var selectedTab: Int
    let geometry: GeometryProxy
    
    var body: some View {
        HStack {
            TabBarButton(imageName: "house", title: "Home", isSelected: selectedTab == 0)
                .onTapGesture { selectedTab = 0 }
            TabBarButton(imageName: "cart", title: "Cart", isSelected: selectedTab == 1)
                .onTapGesture { selectedTab = 1 }
            TabBarButton(imageName: "person", title: "Profile", isSelected: selectedTab == 2)
                .onTapGesture { selectedTab = 2 }
        }
        .frame(width: geometry.size.width, height: 50 + (geometry.safeAreaInsets.bottom > 0 ? geometry.safeAreaInsets.bottom : 16))
        .background(
            Image("bottomnavbar")
                .resizable()
                .aspectRatio(contentMode: .fill)
        )
        .clipShape(CustomCorner(radius: 25, corners: [.topLeft, .topRight]))
    }
}

struct TabBarButton: View {
    let imageName: String
    let title: String
    let isSelected: Bool
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: imageName)
                .font(.system(size: 24))
            Text(title)
                .font(.system(size: 10))
        }
        .foregroundColor(isSelected ? .white : .gray)
        .frame(maxWidth: .infinity)
    }
}

struct CustomCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

#Preview {
    MainTabView()
        .environmentObject(ProfileViewModel(authViewModel: AuthViewModel()))
        .environmentObject(CartViewModel())
        .environmentObject(WishlistViewModel())
}
