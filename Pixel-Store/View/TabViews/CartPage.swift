//
//  CartPage.swift
//  Pixel-Store
//
//  Created by Ahmed Sayed on 08/02/2024.
//

import SwiftUI

struct CartPage: View {
    @EnvironmentObject var sharedData: SharedDataModel
    
    //delete option
    @State var showDeleteOption: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        HStack {
                            Text("Basket")
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
                            .disabled(sharedData.cartProducts.isEmpty ? true : false)
                            .opacity(sharedData.cartProducts.isEmpty ? 0 : 1)
                        }
                        
                        //checking if cart products is empty
                        if sharedData.cartProducts.isEmpty {
                            Group {
                                Image(systemName: "cart.fill.badge.minus")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 150, height: 150)
                                    .padding()
                                    .padding(.top)
                                Text("No Items added!")
                                    .font(.custom(customFont, size: 25))
                                    .fontWeight(.semibold)
                                Text("Click add button to add to basket.")
                                    .font(.custom(customFont, size: 18))
                                    .foregroundStyle(Color.gray)
                                    .padding()
                                    .padding(.top, 10)
                                    .multilineTextAlignment(.center)
                            }
                        } else {
                            VStack(spacing: 15) {
                                ForEach($sharedData.cartProducts) { $product in
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
                                        CardView(product: $product)
                                    }
                                }
                            }
                            .padding(.top, 20)
                            .padding(.horizontal)
                        }
                    }
                    .padding()
                }
                
                //total and checkout button
                if !sharedData.cartProducts.isEmpty {
                    Group {
                        HStack {
                            Text("Total")
                                .font(.custom(customFont, size: 14))
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Text(sharedData.getTotalPrice())
                                .font(.custom(customFont, size: 18).bold())
                                .foregroundStyle(Color.indigo)
                        }
                        
                        Button {
                            
                        } label: {
                            Text("Checkout")
                                .font(.custom(customFont, size: 20).bold())
                                .foregroundStyle(Color.white)
                                .padding(.vertical, 20)
                                .frame(maxWidth: .infinity)
                                .background(
                                    Color.indigo
                                        .cornerRadius(15)
                                        .shadow(radius: 5)
                                )
                        }
                        .padding(.vertical)
                    }
                    .padding(.horizontal, 25)
                }
            }
                .toolbar(.hidden)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("HomeBG").ignoresSafeArea())

        }
    }
    
    func deleteProduct(product: Product) {
        if let index = sharedData.cartProducts.firstIndex(where: { currentProduct in
            return product.id == currentProduct.id
        }) {
            let _ = withAnimation {
                sharedData.cartProducts.remove(at: index)
            }
        }
    }
}

#Preview {
    CartPage()
        .environmentObject(SharedDataModel())
}

//making Product as binding to be updated realtime
struct CardView: View {
    
    @Binding var product: Product
    
    var body: some View {
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
                //quantity buttons
                HStack(spacing: 10) {
                    Text("Quantity")
                        .font(.custom(customFont, size: 14))
                        .foregroundStyle(Color.gray)
                    
                    Button {
                        product.quantity = (product.quantity > 0 ? (product.quantity - 1) : 0)
                    } label: {
                        Image(systemName: "minus")
                            .font(.caption)
                            .foregroundStyle(Color.white)
                            .frame(width: 20, height: 20)
                            .background(Color.gray)
                            .cornerRadius(4)
                    }
                    
                    Text("\(product.quantity)")
                        .font(.custom(customFont, size: 14))
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.black)
                    
                    Button {
                        product.quantity += 1
                    } label: {
                        Image(systemName: "plus")
                            .font(.caption)
                            .foregroundStyle(Color.white)
                            .frame(width: 20, height: 20)
                            .background(Color.gray)
                            .cornerRadius(4)
                    }
                }
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
