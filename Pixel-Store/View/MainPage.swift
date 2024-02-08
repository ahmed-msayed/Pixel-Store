//
//  MainPage.swift
//  Pixel-Store
//
//  Created by Ahmed Sayed on 05/01/2024.
//

import SwiftUI

struct MainPage: View {
    
    //current tab
    @State var currentTab: Tab = .home
    
    @StateObject var sharedData: SharedDataModel = SharedDataModel()
    
    //animation namespace
    @Namespace var animation
    
    //hide tabbar
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        //tab view
        VStack (spacing: 0) {
            TabView(selection: $currentTab) {
                Home(animation: animation)
                    .environmentObject(sharedData)
                    .tag(Tab.home)
                LikedPage()
                    .environmentObject(sharedData)
                    .tag(Tab.like)
                ProfilePage().tag(Tab.profile)
                CartPage()
                    .environmentObject(sharedData)
                    .tag(Tab.cart)
            }
            
            //custom tabbar
            HStack (spacing: 0) {
                ForEach(Tab.allCases, id: \.self) {tab in
                    Button {
                        currentTab = tab
                    } label: {
                        Image(tab.rawValue)
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                        //little shadow
                            .background(
                                Color.indigo
                                    .opacity(0.2)
                                    .cornerRadius(20)
                                    .blur(radius: 5)
                                    .padding(-7)
                                    .opacity(currentTab == tab ? 1 : 0)
                            )
                        //
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(currentTab == tab ? Color.indigo : Color.black.opacity(0.5))
                    }
                }
            }
            .padding([.horizontal, .top])
            .padding(.bottom, 10)
        }
        .background(Color("HomeBG").ignoresSafeArea())
        .overlay {
            ZStack {
                //detail page
                if let product = sharedData.productDetails, sharedData.showProductDetails {
                    ProductDetailView(product: product, animation: animation)
                        .environmentObject(sharedData)
                    //adding transitions
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .opacity))
                }
            }
        }
    }
}

#Preview {
    MainPage()
}

//tab cases, case iteratable "allcases"
enum Tab: String, CaseIterable {
    case home = "home-icon"
    case like = "like-icon"
    case profile = "profile-icon"
    case cart = "cart-icon"
}
