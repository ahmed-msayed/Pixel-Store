//
//  HomeViewModel.swift
//  Pixel-Store
//
//  Created by Ahmed Sayed on 06/01/2024.
//

import SwiftUI
import Combine

//use combine to monitor search field, and search after 0.5 seconds wait

class HomeViewModel: ObservableObject {
    
    @Published var productType: ProductType = .wearable
    
    //sample products
    @Published var products: [Product] = [
        Product(type: .wearable, title: "Apple Watch", subtitle: "Series Ultra: Black", price: "$359", productImage: "Apple-Watch-Ultra"),
        Product(type: .wearable, title: "Samsung Watch", subtitle: "Watch 5 Pro: Black", price: "$180", productImage: "Galaxy-Watch-5-Pro"),
        Product(type: .wearable, title: "Apple Watch", subtitle: "Watch Series 8: Grey", price: "$400", productImage: "apple-watch-8"),
        Product(type: .wearable, title: "Samsung Watch", subtitle: "Galaxy Watch 6: Black", price: "$180", productImage: "galaxy-watch-6"),
        Product(type: .wearable, title: "Xiaomi Watch", subtitle: "Redmi Lite 2: Blue", price: "$90", productImage: "xiaomi-redmi-2"),
        Product(type: .phone, title: "iPhone 13", subtitle: "Blue", price: "$699", productImage: "Iphone-13"),
        Product(type: .phone, title: "iPhone 15", subtitle: "Pro Max: Grey", price: "$800", productImage: "Iphone-15-Pro-Max"),
        Product(type: .laptop, title: "Dell Laptop", subtitle: "Vostro - Grey", price: "$999", productImage: "DELL-Laptop"),
        Product(type: .laptop, title: "Dell Laptop", subtitle: "Inspect - Grey", price: "$900", productImage: "DELL-Laptop"),
        Product(type: .printer, title: "HP Printer", subtitle: "Laser Printer", price: "$500", productImage: "HP-Laser-Printer"),
        Product(type: .storage, title: "Western HDD", subtitle: "HDD 1 TB", price: "$150", productImage: "WD-Hard-Drive"),
        Product(type: .speaker, title: "JBL Speaker", subtitle: "JBL GO3", price: "$200", productImage: "JBL-GO3"),
        Product(type: .powerBank, title: "Anker Powerbank", subtitle: "10,000 Amp", price: "$230", productImage: "Anker-Powerbank")
    ]
    
    //filtered products
    @Published var filteredProducts: [Product] = []
    
    //more products on the type
    @Published var showMoreProductsOnType: Bool = false
    
    //search data
    @Published var searchText: String = ""
    @Published var searchActivated: Bool = false
    @Published var searchedProducts: [Product]?
    
    var searchCancellable: AnyCancellable?
    
    init() {
        filterProductByType()
        
        searchCancellable = $searchText.removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: { str in
                if str != "" {
                    self.filterProductBySearch()
                } else {
                    self.searchedProducts = nil
                }
            })
    }
    
    func filterProductByType() {
        DispatchQueue.global(qos: .userInteractive).async {
            let results = self.products
                .lazy   //since it will require more memory
                .filter { product in
                    return product.type == self.productType
                }
                .prefix(4)  //to limit results
            
            DispatchQueue.main.async {
                self.filteredProducts = results.compactMap({ product in
                    return product
                })
            }
        }
    }
    
    func filterProductBySearch() {
        DispatchQueue.global(qos: .userInteractive).async {
            let results = self.products
                .lazy   //since it will require more memory
                .filter { product in
                    return product.title.lowercased().contains(self.searchText.lowercased())
                }
            
            DispatchQueue.main.async {
                self.searchedProducts = results.compactMap({ product in
                    return product
                })
            }
        }
    }
}
