//
//  OnBoardingPage.swift
//  Pixel-Store
//
//  Created by Ahmed Sayed on 08/12/2023.
//

import SwiftUI

let customFont = "Raleway-Regular"

struct OnBoardingPage: View {
    var body: some View {
        VStack(alignment: .leading){
            Text("Find your\nGadget")
                .font(.custom(customFont, size: 55))
                .fontWeight(.bold)
                .foregroundColor(.white)
            Image("icons8-electronics-store-100")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Button {

            } label: {
                Text("Get Started")
                    .font(.custom(customFont, size: 18))
                    .fontWeight(.semibold)
                    .padding(.vertical, 18)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 5)
                    .foregroundStyle(Color.indigo)
            }
            .padding(.horizontal, 30)
            // for larger displays
            .offset(y: getRect().height < 720 ? 20 : 40)
            
            Spacer()
        }
        .padding()
        .padding(.top, getRect().height < 720 ? 0 : 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color.indigo
        )
    }
}

struct OnBoardingPage_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingPage()
            .previewDevice("iPhone 15 Pro")
//        OnBoardingPage()
//            .previewDevice("iPhone Xs")
    }
}
