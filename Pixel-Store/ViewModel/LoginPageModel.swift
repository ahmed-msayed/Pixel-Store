//
//  LoginPageModel.swift
//  Pixel-Store
//
//  Created by Ahmed Sayed on 09/12/2023.
//

import SwiftUI

class LoginPageModel: ObservableObject {

    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showPassword: Bool = false
    
    @Published var registeredUser: Bool = false
    @Published var reEnterPassword: String = ""
    @Published var showReEnterPassword: Bool = false
    
    
    func login() {
        
    }

    func register() {
        
    }
    
    func forgotPassword() {
        
    }
    
    
}
