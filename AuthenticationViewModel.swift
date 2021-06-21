//
//  AuthenticationViewModel.swift
//  MockInstagram
//
//  Created by Hui Chih Wang on 2021/6/22.
//

import Foundation

struct LogInViewModel {
    var email: String?
    var pwd: String?
    
    var isFormValid: Bool {
        guard let email = email, let pwd = pwd
        else {
            return false
        }
        
        return !email.isEmpty && !pwd.isEmpty
    }
}
