//
//  TwoPartTextButton.swift
//  MockInstagram
//
//  Created by Hui Chih Wang on 2021/6/21.
//

import UIKit

class TwoPartTextButton: UIButton {
    func setText(first: String, second: String) {
        let string = NSMutableAttributedString()
        
        let firstStr = NSAttributedString(
            string: first + "  ",
            attributes: [
                .font: UIFont.systemFont(ofSize: 14),
                .foregroundColor: UIColor.white
            ]
        )
        
        let secondStr = NSAttributedString(
            string: second,
            attributes: [
                .font: UIFont.systemFont(ofSize: 14, weight: .bold),
                .foregroundColor: UIColor.white
            ]
        )
        
        string.append(firstStr)
        string.append(secondStr)
            
        setAttributedTitle(string, for: .normal)
    }
}
