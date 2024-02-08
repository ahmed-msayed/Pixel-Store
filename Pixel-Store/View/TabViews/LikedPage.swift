//
//  LikedPage.swift
//  Pixel-Store
//
//  Created by Ahmed Sayed on 01/02/2024.
//

import SwiftUI

struct LikedPage: View {
    @EnvironmentObject var sharedData: SharedDataModel
    
    //delete option
    @State var showDeleteOption: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    HStack {
                        Text("Favorites")
                            .font(.custom(customFont, size: 28).bold())
                        Spacer()
                        Button {
                            withAnimation {
                                showDeleteOption.toggle()
                            }
                        } label: {
                            Image("delete-icon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                        }
                        .disabled(sharedData.likedProducts.isEmpty ? true : false)
                        .opacity(sharedData.likedProducts.isEmpty ? 0 : 1)
                    }
                    
                    //checking if liked products is empty
                    if sharedData.likedProducts.isEmpty {
                        Group {
                            Image(systemName: "heart.slash.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150, height: 150)
                                .padding()
                                .padding(.top)
                            Text("No Favourites!")
                                .font(.custom(customFont, size: 25))
                                .fontWeight(.semibold)
                            Text("Click like button on any product to add to liked products.")
                                .font(.custom(customFont, size: 18))
                                .foregroundStyle(Color.gray)
                                .padding()
                                .padding(.top, 10)
                                .multilineTextAlignment(.center)
                        }
                    } else {
                        VStack(spacing: 15) {
                            ForEach(sharedData.likedProducts) { product in
                                HStack(spacing: 0) {
                                    if showDeleteOption {
                                        Button {
                                            deleteProduct(product: product)
                                        } label: {
                                            Image(systemName: "minus.circle.fill")
                                                .font(.title2)
                                                .foregroundStyle(Color.red)
                                        }
                                        .padding(.trailing)
                                    }
                                    
                                    cardView(product: product)
                                }
                            }
                        }
                        .padding(.top, 20)
                        .padding(.horizontal)
                    }
                }
                .padding()
            }
            .toolbar(.hidden)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("HomeBG").ignoresSafeArea())
        }
    }
    
    @ViewBuilder
    func cardView(product: Product) -> some View {
        HStack(spacing: 15) {
            Image(product.productImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
            VStack(alignment: .leading, spacing: 8) {
                Text(product.title)
                    .font(.custom(customFont, size: 18).bold())
                    .lineLimit(1)
                Text(product.subtitle)
                    .font(.custom(customFont, size: 17))
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.indigo)
                Text("Type: \(product.type.rawValue)")
                    .font(.custom(customFont, size: 13))
                    .foregroundStyle(Color.gray)
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
    
    func deleteProduct(product: Product) {
        if let index = sharedData.likedProducts.firstIndex(where: { currentProduct in
            return product.id == currentProduct.id
        }) {
            let _ = withAnimation {
                sharedData.likedProducts.remove(at: index)
            }
        }
    }
}

#Preview {
    LikedPage()
        .environmentObject(SharedDataModel())
}
