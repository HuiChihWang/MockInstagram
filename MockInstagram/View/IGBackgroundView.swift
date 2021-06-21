//
//  GradientView.swift
//  MockInstagram
//
//  Created by Hui Chih Wang on 2021/6/21.
//

import UIKit

class IGBackgroundView: UIView {
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [#colorLiteral(red: 0.5411764706, green: 0.137254902, blue: 0.5294117647, alpha: 1), #colorLiteral(red: 0.9137254902, green: 0.2509803922, blue: 0.3411764706, alpha: 1), #colorLiteral(red: 0.9490196078, green: 0.4431372549, blue: 0.1294117647, alpha: 1)].map{ $0.cgColor }
        gradient.locations = [0.0, 0.4, 0.7]
        layer.addSublayer(gradient)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
