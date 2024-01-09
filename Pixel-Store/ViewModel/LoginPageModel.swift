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
    
    //log status
    @AppStorage("lgog_status") var log_status: Bool = false
    
    
    func login() {
        withAnimation {
            log_status = true
        }
    }

    func register() {
        withAnimation {
            log_status = true
        }
    }
    
    func forgotPassword() {
        
    }
    
    
}
