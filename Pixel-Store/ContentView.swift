//
//  ContentView.swift
//  Pixel-Store
//
//  Created by Ahmed Sayed on 07/12/2023.
//

import SwiftUI

struct ContentView: View {
    //log status
    @AppStorage("lgog_status") var log_status: Bool = false
    
    var body: some View {
        if log_status {
            MainPage()
        } else {
            OnBoardingPage()
        }
    }
}

#Preview {
    ContentView()
}
