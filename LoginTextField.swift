//
//  LoginTextView.swift
//  MockInstagram
//
//  Created by Hui Chih Wang on 2021/6/21.
//

import UIKit

class LoginTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)

    init(fieldName: String, isSecure: Bool = false) {
        super.init(frame: .zero)
        textColor = .white
        backgroundColor = UIColor(white: 1, alpha: 0.1)
        keyboardType = .emailAddress
        keyboardAppearance = .dark
        
        attributedPlaceholder = NSAttributedString(
            string: fieldName,
            attributes: [
                .foregroundColor: UIColor(white: 1, alpha: 0.7)
            ]
        )
        
        isSecureTextEntry = isSecure
        layer.cornerRadius = 5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return super.textRect(forBounds: bounds).inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return super.editingRect(forBounds: bounds).inset(by: padding)
    }
    
    
    
}
