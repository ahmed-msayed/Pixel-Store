//
//  Home.swift
//  Pixel-Store
//
//  Created by Ahmed Sayed on 05/01/2024.
//

import SwiftUI

struct Home: View {
    //for matched geometry effect
    @Namespace var animation
    
    @StateObject var homeData: HomeViewModel = HomeViewModel()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(spacing: 20) {
                
                //search bar
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
                .frame(width: getRect().width / 1.6)
                .padding(.horizontal, 25)
                
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
            }
            .padding(.vertical)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("HomeBG"))
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
}

#Preview {
    Home()
}
