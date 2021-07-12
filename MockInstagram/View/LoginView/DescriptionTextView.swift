//
//  DescriptionTextView.swift
//  MockInstagram
//
//  Created by Hui Chih Wang on 2021/7/12.
//

import Foundation
import UIKit

class DesciptionTextView: UIView {
    private let textFiled = DesctiptionTextField()
    private let textLimit: Int
    
    private var textLength: Int {
        textFiled.text?.count ?? 0
    }
    
    private var textLabel: String {
        "\(textLength) / \(textLimit)"
    }
    
    init(contentLimit: Int = 100) {
        self.textLimit = contentLimit
        
        super.init(frame: .zero)
        backgroundColor = #colorLiteral(red: 0.850723207, green: 0.9530975223, blue: 0.9585469365, alpha: 1)
        layer.cornerRadius = 3
        configureUI()
        textFiled.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let wordNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .right
        return label
    }()
    
    private func configureUI() {
        addSubview(textFiled)
        addSubview(wordNumberLabel)
        
        textFiled.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor)
        
        wordNumberLabel.anchor(top: textFiled.bottomAnchor,  bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingBottom: 8, paddingRight: 8)
        textFiled.addTarget(self, action: #selector(didTextChanged), for: .editingChanged)
        
        wordNumberLabel.text = textLabel
    }
    
    @objc private func didTextChanged() {
        wordNumberLabel.text = textLabel
    }
}

extension DesciptionTextView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= textLimit
    }
}
class DesctiptionTextField: UITextField {
    let padding = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    init() {
        super.init(frame: .zero)
        placeholder = "Enter Description..."
        contentVerticalAlignment = .top
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
