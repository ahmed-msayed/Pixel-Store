//
//  SharedDataModel.swift
//  Pixel-Store
//
//  Created by Ahmed Sayed on 12/01/2024.
//

import SwiftUI

class SharedDataModel: ObservableObject {

    //product details data
    @Published var productDetails: Product?
    @Published var showProductDetails: Bool = false
    
    //matched geometry effect on search page
    @Published var fromSearchPage: Bool = false
    
    //liked products
    @Published var likedProducts: [Product] = []
    
    //cart products
    @Published var cartProducts: [Product] = []
}
