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
            Text("Welcome\nBack")
                .font(.custom(customFont, size: 55).bold())
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: getRect().height / 3.5)
                .padding()
                .background(
                    ZStack {
                        LinearGradient(colors: [
                            Color.pink,
                            Color.pink.opacity(0.8),
                            Color.indigo
                        ], startPoint: .top, endPoint: .bottom)
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                        .clipShape(Circle())
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                        .padding(.trailing)
                        .offset(y: -25)
                        .ignoresSafeArea()
                        
                        Circle()
                            .strokeBorder(Color.white.opacity(0.3), lineWidth: 3)
                            .frame(width: 30, height: 30)
                            .blur(radius: 2)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                            .padding(30)
                        
                        Circle()
                            .strokeBorder(Color.white.opacity(0.3), lineWidth: 3)
                            .frame(width: 23, height: 23)
                            .blur(radius: 2)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                            .padding(30)
                    }
                )
            
            ScrollView(.vertical, showsIndicators: false) {
                //Login Page Form
                VStack(spacing: 15) {
                    Text("Login")
                        .font(.custom(customFont, size: 22).bold())
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                    
                    customTextField(icon: "envelope", title: "Email", hint: "hint@test.com", value: $loginData.email, showPassword: .constant(false))
                        .padding(.top, 30)
                    
                    customTextField(icon: "lock", title: "Password", hint: "123456", value: $loginData.password, showPassword: $loginData.showPassword)
                        .padding(.top, 10)
                    
                    //Re-Enter Password when Registering
                    if loginData.registeredUser {
                        customTextField(icon: "lock", title: "Re-Enter Password", hint: "123456", value: $loginData.reEnterPassword, showPassword: $loginData.showReEnterPassword)
                            .padding(.top, 10)
                    }
                    
                    //Forgot Password Button
                    Button {
                        loginData.forgotPassword()
                    } label: {
                        Text("Forgot Password?")
                            .font(.custom(customFont, size: 14))
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.indigo)
                    }
                    .padding(.top, 8)
                    .frame(maxWidth: .infinity, alignment: .leading)

                    //Login Button
                    Button {
                        if loginData.registeredUser {
                            loginData.login()
                        } else {
                            loginData.register()
                        }
                    } label: {
                        Text(loginData.registeredUser ? "Register" :"Login")
                            .font(.custom(customFont, size: 17)).bold()
                            .padding(.vertical, 20)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(Color.white)
                            .background(Color.indigo)
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .circular))
                            .shadow(color: .black.opacity(0.7), radius: 5, x: 5, y: 5)
                    }
                    .padding(.top, 8)
                    .padding(.horizontal)
                    
                    //Register User Button
                    Button {
                        withAnimation {
                            loginData.registeredUser.toggle()
                        }
                    } label: {
                        Text(loginData.registeredUser ? "Back To Login" : "Create Account")
                            .font(.custom(customFont, size: 14))
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.indigo)
                    }
                    .padding(.top, 8)
                }
                .padding(30)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color.white
                    .clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: 30))
                    .ignoresSafeArea()
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.indigo)
        
        //Clear Data When Change
        .onChange(of: loginData.registeredUser) { oldValue, newValue in
            loginData.email = ""
            loginData.password = ""
            loginData.reEnterPassword = ""
            loginData.showPassword = false
            loginData.showReEnterPassword = false
        }
        
    }
    
    //Custom Text Fields Function
    @ViewBuilder
    func customTextField(icon: String, title: String, hint: String, value: Binding<String>, showPassword: Binding<Bool>) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Label(
                title: { Text(title).font(.custom(customFont, size: 14)) },
                icon: { Image(systemName: icon).foregroundStyle(Color.black.opacity(0.8)) }
            )
            if title.contains("Password") && !showPassword.wrappedValue {
                SecureField(hint, text: value)
                    .padding(.top, 2)
            } else {
                TextField(hint, text: value)
                    .padding(.top, 2)
            }
            Divider()
                .background(Color.black.opacity(0.5))
        }
        // Show Password Button
        .overlay (
            Group {
                if title.contains("Password") {
                    Button (action: {
                        showPassword.wrappedValue.toggle()

                    }, label: {
                        Text(showPassword.wrappedValue ? "Hide" : "Show")
                            .font(.custom(customFont, size: 13).bold())
                            .foregroundStyle(Color.indigo)
                    }) 
                    .offset(y: 8)
                }
            }, alignment: .trailing
        )
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
            .previewDevice("iPhone 15 Pro")
        //        LoginPage()
        //            .previewDevice("iPhone Xs")
    }
}
