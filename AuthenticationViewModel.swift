//
//  AuthenticationViewModel.swift
//  MockInstagram
//
//  Created by Hui Chih Wang on 2021/6/22.
//

import Foundation
import UIKit

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
    
    var buttonBackground: UIColor {
        isFormValid ? #colorLiteral(red: 0.8441327214, green: 0.2275986373, blue: 0.3763634861, alpha: 1) : #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).withAlphaComponent(0.5)
    }
    
    var textColor: UIColor {
        isFormValid ? .white : .gray
    }
}

struct RegistrationViewModel {
    var email: String?
    var pwd: String?
    var name: String?
    var idName: String?
    
    var isFormValid: Bool {
        guard let email = email, let pwd = pwd, let name = name, let idName = idName
        else {
            return false
        }
        
        return !email.isEmpty && !pwd.isEmpty && !idName.isEmpty && !name.isEmpty
    }
    
    var buttonBackground: UIColor {
        isFormValid ? #colorLiteral(red: 0.8441327214, green: 0.2275986373, blue: 0.3763634861, alpha: 1) : #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).withAlphaComponent(0.5)
    }
    
    var textColor: UIColor {
        isFormValid ? .white : .gray
    }
}
