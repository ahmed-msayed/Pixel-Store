//
//  SearchView.swift
//  Pixel-Store
//
//  Created by Ahmed Sayed on 09/01/2024.
//

import SwiftUI

struct SearchView: View {
    
        var animation: Namespace.ID
    @EnvironmentObject var homeData: HomeViewModel
    
    //activate text state with FocusState
    @FocusState var startTF: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 20) {
                //close button
                Button {
                    withAnimation {
                        homeData.searchActivated = false
                        homeData.searchText = ""
                    }
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundStyle(Color.black.opacity(0.7))
                }
                
                //sarch bar
                HStack(spacing: 15) {
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundStyle(Color.gray)
                    TextField("Search", text: $homeData.searchText)
                        .focused($startTF)
                        .textCase(.lowercase)
                        .autocorrectionDisabled()
                }
                .padding(.vertical, 12)
                .padding(.horizontal)
                .background(
                    Capsule().strokeBorder(Color.indigo, lineWidth: 1.5)
                )
                                .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                .padding(.trailing,20)
            }
            .padding(.horizontal)
            .padding(.top)
            .padding(.bottom, 10)
            
            //show search progress, or show no results
            if let products = homeData.searchedProducts {
                if products.isEmpty {
                    //no results found
                    VStack(spacing: 10) {
                        Image("noitemsfound")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.top, 60)
                        Text("No Items Found!")
                            .font(.custom(customFont, size: 22).bold())
                        Text("Try different word or an alternative product")
                            .font(.custom(customFont, size: 16))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 30)
                    }
                    .padding()
                } else {
                    //filter results
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 0) {
                            //found items
                            Text("Found \(products.count) Items")
                                .font(.custom(customFont, size: 24).bold())
                                .padding(.vertical)
                            
                            //staggered grid
                            StaggeredGrid(columns: 2, spacing: 20, list: products) { product in
                                //card view
                                productCardView(product: product)
                            }
                        }
                        .padding()
                    }
                }
            } else {
                ProgressView()
                    .padding(.top, 30)
                    .opacity(homeData.searchText == "" ? 0 : 1)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(
            Color("HomeBG")
                .ignoresSafeArea()
        )
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                startTF = true
            }
        }
    }
    
    @ViewBuilder
    func productCardView(product: Product) -> some View {
        VStack(spacing: 10) {
            Image(product.productImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .offset(y: -50)
                .padding(.bottom, -50)
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
        .padding(.top, 50)
    }
}

#Preview {
    Home()
}
