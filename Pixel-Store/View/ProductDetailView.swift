//
//  ProductDetailView.swift
//  Pixel-Store
//
//  Created by Ahmed Sayed on 12/01/2024.
//

import SwiftUI

struct ProductDetailView: View {
    
    var product: Product
    
    //for matched geometry effect
    var animation: Namespace.ID
    
    //shared data model
    @EnvironmentObject var sharedData: SharedDataModel
    
    var body: some View {
        VStack {
            //title bar & product image
            VStack {
                HStack {
                    Button {
                        withAnimation(.easeOut) {
                            sharedData.showProductDetails = false
                        }
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundStyle(Color.black.opacity(0.7))
                    }
                    Spacer()
                    Image(systemName: "heart.fill")
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 22, height: 22)
                        .foregroundStyle(Color.black.opacity(0.7))
                }
                .padding()
                
                Image(product.productImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    //matched geometry
                    .matchedGeometryEffect(id: "\(product.id)\(sharedData.fromSearchPage ? "SEARCH" : "IMAGE")", in: animation)
                    .padding(.horizontal)
                    .offset(y: -12)
                    .frame(maxHeight: .infinity)
            }
            .frame(height: getRect().height / 2.7)
            .zIndex(1)
            
            //product details
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 15) {
                    Text(product.title)
                        .font(.custom(customFont, size: 20).bold())
                    Text(product.subtitle)
                        .font(.custom(customFont, size: 18))
                        .foregroundStyle(Color.gray)
                    Text("Get Apple TV+ Free For A Year")
                        .font(.custom(customFont, size: 16))
                        .padding(.top)
                    Text("Available when you purchase any new iPhone, iPad, iPod Touch, Mac or Apple TV, £4.99/month after free trial.")
                        .font(.custom(customFont, size: 15))
                        .foregroundColor(.gray)
                    Button {
                        
                    } label: {
                        Label {
                            Image(systemName: "arrow.right")
                        } icon: {
                            Text("Full Description")
                        }
                        .font(.custom(customFont, size: 15).bold())
                        .foregroundStyle(Color.indigo)
                    }
                    HStack {
                        Text("Total")
                            .font(.custom(customFont, size: 17))
                        Spacer()
                        Text(product.price)
                            .font(.custom(customFont, size: 20).bold())
                            .foregroundStyle(Color.indigo)
                    }
                    .padding(.vertical, 20)
                    
                    //add to cart
                    Button {
                        
                    } label: {
                        Text("Add To Cart")
                            .font(.custom(customFont, size: 20).bold())
                            .foregroundStyle(Color.white)
                            .padding(.vertical,20)
                            .frame(maxWidth: .infinity)
                            .background(
                                Color.indigo
                                    .cornerRadius(15)
                                    .shadow(radius: 5)
                            )
                    }
                }
                .padding([.horizontal,.bottom], 20)
                .padding(.top, 25)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color.white
                    .clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: 25))
                    .ignoresSafeArea()
            )
            .zIndex(0)
        }
        .background(Color("HomeBG").ignoresSafeArea())
    }
}

#Preview {
    //sample for preview
//    ProductDetailView(product: HomeViewModel().products[0])
//        .environmentObject(SharedDataModel())
    MainPage()
}
