//
//  profileView.swift
//  MockInstagram
//
//  Created by Hui Chih Wang on 2021/7/10.
//

import Foundation
import UIKit
import SDWebImage

class ProfileNameView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        addSubview(profileNameLabel)
        
        imageView.centerX(inView: self, topAnchor: topAnchor)
        profileNameLabel.centerX(inView: self)
        profileNameLabel.anchor(bottom: self.bottomAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImageURL(url: String) {
        imageView.sd_setImage(with: URL(string: url))
    }
    
    var nameLabelText: String? {
        get {
            return profileNameLabel.text
        }
        set {
            profileNameLabel.text = newValue
        }
    }
    
    private let profileNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .gray
        
        let imageSize: CGFloat = 80
        imageView.setDimensions(height: imageSize, width: imageSize)
        imageView.layer.cornerRadius = imageSize / 2
        return imageView
    }()
}
