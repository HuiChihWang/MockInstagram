//
//  SearchResultTableCell.swift
//  MockInstagram
//
//  Created by Hui Chih Wang on 2021/7/10.
//

import Foundation
import UIKit
import SDWebImage

class SearchResultTableCell: UITableViewCell {
    var user: User? {
        didSet {
            configure()
        }
    }
    
    override func prepareForReuse() {
        user = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        contentView.addSubview(profileImageview)
        let imageSize: CGFloat = 60
        profileImageview.setDimensions(height: imageSize, width: imageSize)
        profileImageview.layer.cornerRadius = imageSize / 2
        profileImageview.centerY(inView: contentView, leftAnchor: contentView.leftAnchor,  paddingLeft: 30)
        
        let labelStack = UIStackView(arrangedSubviews: [userNameLabel, fullNameLabel])
        labelStack.axis = .vertical
        labelStack.alignment = .leading
        labelStack.spacing = 3
        
        contentView.addSubview(labelStack)
        labelStack.centerY(inView: contentView, leftAnchor: profileImageview.rightAnchor, paddingLeft: 20)
    }
    
    private let profileImageview: UIImageView = {
       let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .gray
        
        return imageView
    }()
    
    private let userNameLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        return label
    }()
    
    private let fullNameLabel: UILabel = {
        let label = UILabel()
         label.textColor = .gray
         label.font = UIFont.systemFont(ofSize: 15)
         return label
    }()
    
    
    private func configure() {
        profileImageview.image = nil
        userNameLabel.text = user?.userName
        fullNameLabel.text = user?.fullName
        
        if let urlString = user?.imageUrl {
            profileImageview.sd_setImage(with: URL(string: urlString))
        }
    }
}
