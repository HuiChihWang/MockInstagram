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
    
    init() {
        super.init(frame: .zero)
        backgroundColor = #colorLiteral(red: 0.850723207, green: 0.9530975223, blue: 0.9585469365, alpha: 1)
        layer.cornerRadius = 3
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let divider: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.setHeight(1)
        return view
    }()
    
    private let wordNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .right
        label.text = "0 / 100"
        return label
    }()
    
    private func configureUI() {
        addSubview(textFiled)
        addSubview(divider)
        addSubview(wordNumberLabel)
        
        textFiled.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor)
        divider.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 7, paddingBottom: 10, paddingRight: 7)
        textFiled.anchor(bottom: divider.topAnchor, paddingBottom: 40)
        
        wordNumberLabel.anchor(top: textFiled.bottomAnchor,  bottom: divider.topAnchor, right: rightAnchor, paddingTop: 5, paddingBottom: 3, paddingRight: 5)
        textFiled.addTarget(self, action: #selector(didTextChanged), for: .editingChanged)
    }
    
    @objc private func didTextChanged() {
        let wordSize = textFiled.text?.count ?? 0
        wordNumberLabel.text = "\(wordSize) / 100"
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
