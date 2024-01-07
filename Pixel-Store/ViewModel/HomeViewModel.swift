//
//  HomeViewModel.swift
//  Pixel-Store
//
//  Created by Ahmed Sayed on 06/01/2024.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var productType: ProductType = .wearable
    
    //sample products
    @Published var products: [Product] = [
        Product(type: .wearable, title: "Apple Watch", subtitle: "Series Ultra: Black", price: "$359", productImage: "Apple-Watch-Ultra"),
        Product(type: .wearable, title: "Samsung Watch", subtitle: "Watch 5 Pro: Black", price: "$180", productImage: "Galaxy-Watch-5-Pro"),
        Product(type: .phone, title: "iPhone 13", subtitle: "Blue", price: "$699", productImage: "Iphone-13"),
        Product(type: .phone, title: "iPhone 15", subtitle: "Pro Max: Grey", price: "$800", productImage: "Iphone-15-Pro-Max"),
        Product(type: .laptop, title: "Dell Laptop", subtitle: "Vostro - Grey", price: "$999", productImage: "DELL-Laptop"),
        Product(type: .laptop, title: "Dell Laptop", subtitle: "Inspect - Grey", price: "$900", productImage: "DELL-Laptop"),
        Product(type: .printer, title: "HP Printer", subtitle: "Laser Printer", price: "$500", productImage: "HP-Laser-Printer"),
        Product(type: .storage, title: "Western HDD", subtitle: "HDD 1 TB", price: "$150", productImage: "WD-Hard-Drive"),
        Product(type: .speaker, title: "JBL Speaker", subtitle: "JBL GO3", price: "$200", productImage: "JBL-GO3"),
        Product(type: .powerBank, title: "Anker Powerbank", subtitle: "10,000 Amp", price: "$230", productImage: "Anker-Powerbank")
    ]
}
