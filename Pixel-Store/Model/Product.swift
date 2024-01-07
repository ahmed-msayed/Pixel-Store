//
//  Product.swift
//  Pixel-Store
//
//  Created by Ahmed Sayed on 06/01/2024.
//

import SwiftUI

//product model
struct Product: Identifiable, Hashable {
    var id = UUID().uuidString
    var type: ProductType
    var title: String
    var subtitle: String
    var description: String = ""
    var price: String
    var productImage: String = ""
    var quantity: Int = 1
}

//product types
enum ProductType: String, CaseIterable {
    case wearable = "Wearable"
    case laptop = "Laptop"
    case printer = "Printer"
    case phone = "Phone"
    case storage = "Storage"
    case powerBank = "PowerBank"
    case speaker = "Speaker"
}
