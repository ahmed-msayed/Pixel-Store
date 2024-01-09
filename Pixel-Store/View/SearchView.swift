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
}

#Preview {
    Home()
}
