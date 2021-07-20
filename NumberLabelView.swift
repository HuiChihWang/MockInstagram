//
//  NumberLabelView.swift
//  MockInstagram
//
//  Created by Hui Chih Wang on 2021/7/10.
//

import UIKit

class NumberLabelView: UIStackView {
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.textColor = .gray
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        return titleLabel
    }()
    
    var text: String? {
        get {
            return label.text
        }
        
        set {
            label.text = newValue
        }
    }
    
    init(title: String) {
        super.init(frame: .zero)
        titleLabel.text = title

        
        addArrangedSubview(label)
        addArrangedSubview(titleLabel)
        axis = .vertical
        spacing = 5
        isUserInteractionEnabled = true
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
