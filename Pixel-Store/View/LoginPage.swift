//
//  LoginPage.swift
//  Pixel-Store
//
//  Created by Ahmed Sayed on 09/12/2023.
//

import SwiftUI

struct LoginPage: View {
    
    @StateObject var loginData: LoginPageModel = LoginPageModel()
    
    var body: some View {
        VStack{
            //welcome back text 3 half of the screen
            VStack {
                
            }
            .frame(height: getRect().height / 3.5)
            
            ScrollView(.vertical, showsIndicators: false) {
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.indigo)
    }
}

#Preview {
    LoginPage()
}
