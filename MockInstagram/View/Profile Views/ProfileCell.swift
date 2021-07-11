//
//  ProfileCell.swift
//  MockInstagram
//
//  Created by Hui Chih Wang on 2021/7/9.
//

import Foundation
import UIKit

class ProfileCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .gray
        
        contentView.addSubview(imageView)
        imageView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
        
    func configure(url: String) {
        imageView.sd_setImage(with: URL(string: url))
    }
}
