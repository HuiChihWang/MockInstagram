//
//  NothingFoundCell.swift
//  MockInstagram
//
//  Created by Hui Chih Wang on 2021/7/11.
//

import Foundation
import UIKit

class NothingFoundCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nothingLabel)
        nothingLabel.setHeight(70)
        nothingLabel.center(inView: contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let nothingLabel: UILabel = {
        let label = UILabel()
        label.text = "No User Found"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
}
