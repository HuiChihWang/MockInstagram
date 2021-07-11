//
//  FetchingCell.swift
//  MockInstagram
//
//  Created by Hui Chih Wang on 2021/7/11.
//

import Foundation
import UIKit

class FetchingCell: UITableViewCell {
    private let spinner = UIActivityIndicatorView(style: .medium)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(spinner)
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        
        isUserInteractionEnabled = false
        
        spinner.center(inView: contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
