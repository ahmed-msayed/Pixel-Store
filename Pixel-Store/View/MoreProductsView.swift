//
//  MoreProductsView.swift
//  Pixel-Store
//
//  Created by Ahmed Sayed on 08/01/2024.
//

import SwiftUI

struct MoreProductsView: View {
    var body: some View {
        VStack {
            Text("More Products")
                .font(.custom(customFont, size: 24).bold())
                .foregroundStyle(Color.black)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color("HomeBG").ignoresSafeArea())
    }
}

#Preview {
    MoreProductsView()
}
