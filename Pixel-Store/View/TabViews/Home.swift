//
//  Home.swift
//  Pixel-Store
//
//  Created by Ahmed Sayed on 05/01/2024.
//

import SwiftUI

struct Home: View {
    //for matched geometry effect
    var animation: Namespace.ID
    
    //shared data
    @EnvironmentObject var sharedData: SharedDataModel
    
    @StateObject var homeData: HomeViewModel = HomeViewModel()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(spacing: 15) {
                
                //search bar
                ZStack {
                    if homeData.searchActivated {
                        searchBarView()
                    } else {
                        searchBarView()
                            .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                    }
                }
                .frame(width: getRect().width / 1.6)
                .padding(.horizontal, 25)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        homeData.searchActivated = true
                    }
                }
                
                //title
                Text("Order online \nCollect in store")
                    .font(.custom(customFont, size: 28)).bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                    .padding(.horizontal, 25)
                
                //products tab
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 18) {
                        ForEach(ProductType.allCases, id: \.self) { type in
                            productTypeView(type: type)
                        }
                    }
                    .padding(.horizontal, 25)
                }
                .padding(.top,28)
                
                //products page
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 25) {
                        ForEach(homeData.filteredProducts) { filteredProduct in
                            //product card
                                productCardView(product: filteredProduct)
                        }
                    }
                    .padding(.horizontal, 25)
                    .padding(.bottom)
                    .padding(.top, 80)
                }
                .padding(.top, 30)
                
                //"See More" button since we limited to 4 products
                Button {
                    homeData.showMoreProductsOnType.toggle()
                } label: {
                    Label {
                        Image(systemName: "arrow.right")
                    } icon: {
                        Text("see more")
                    }
                    .font(.custom(customFont, size: 15)).bold()
                    .foregroundStyle(Color.indigo)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing)
                .padding(.top, 10)
            }
            .padding(.vertical)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("HomeBG"))
        
        //update data when tab changes
        .onChange(of: homeData.productType) {
            homeData.filterProductByType()
        }
        //show see more products
        .sheet(isPresented: $homeData.showMoreProductsOnType, content: {
            MoreProductsView()
        })
        //display search view
        .overlay {
            ZStack {
                if homeData.searchActivated {
                    SearchView(animation: animation)
                        .environmentObject(homeData)
                }
            }
        }
    }
    
    @ViewBuilder
    func searchBarView() -> some View {
        HStack(spacing: 15) {
            Image(systemName: "magnifyingglass")
                .font(.title2)
                .foregroundStyle(Color.gray)
            TextField("Search", text: .constant(""))
                .disabled(true)
        }
        .padding(.vertical, 12)
        .padding(.horizontal)
        .background(Capsule().strokeBorder(Color.gray, lineWidth: 0.8))
    }
    
    @ViewBuilder
    func productTypeView(type: ProductType) -> some View {
        Button {
            withAnimation {
                homeData.productType = type
            }
        } label: {
            Text(type.rawValue)
                .font(.custom(customFont, size: 15))
                .fontWeight(.semibold)
            //change color based on current product type
                .foregroundStyle(Color(homeData.productType == type ? Color.indigo : Color.gray))
                .padding(.bottom, 10)
            //add line under selected type
                .overlay (
                    ZStack {
                        if homeData.productType == type {
                            Capsule()
                                .fill(Color.indigo)
                                //matched geometry effect
                                .matchedGeometryEffect(id: "PRODUCTTAB", in: animation)
                                //
                                .frame(height: 2)
                        }
                    }
                        .padding(.horizontal, -5)
                    ,alignment: .bottom
                )
        }
    }
    
    @ViewBuilder
    func productCardView(product: Product) -> some View {
        VStack(spacing: 10) {
            ZStack {
                if sharedData.showProductDetails {
                    Image(product.productImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .opacity(0)
                } else {
                    Image(product.productImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: "\(product.id)IMAGE", in: animation)
                }
            }
                .frame(width: getRect().width / 2.5, height: getRect().width / 2.5)
                //moving half the image over the frame
                .offset(y: -80)
                .padding(.bottom, -80)
            Text(product.title)
                .font(.custom(customFont, size: 18))
                .fontWeight(.semibold)
                .padding(.top)
            Text(product.subtitle)
                .font(.custom(customFont, size: 14))
                .foregroundStyle(Color.gray)
            Text(product.price)
                .font(.custom(customFont, size: 16))
                .foregroundStyle(Color.indigo)
                .fontWeight(.bold)
                .padding(.top,5)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 22)
        .background(Color.white
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 25, height: 25)))
        )
        //show product detail when tapped
        .onTapGesture {
            withAnimation(.easeInOut) {
                sharedData.productDetails = product
                sharedData.showProductDetails = true
            }
        }
    }
}

#Preview {
    MainPage()
}
