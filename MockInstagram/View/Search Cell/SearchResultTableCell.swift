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
        profileImageview.anchor(top: contentView.topAnchor, left:contentView.leftAnchor, bottom: contentView.bottomAnchor, paddingTop: 12, paddingLeft: 30, paddingBottom: 12)
        
        let labelStack = UIStackView(arrangedSubviews: [userNameLabel, fullNameLabel])
        labelStack.axis = .vertical
        labelStack.alignment = .leading
        labelStack.spacing = 3
        
        contentView.addSubview(labelStack)
        labelStack.centerY(inView: contentView, leftAnchor: profileImageview.rightAnchor, paddingLeft: 20)
    }
    
    private let profileImageview: UIImageView = {
       let imageView = UIImageView()
        let imageSize: CGFloat = 65
        imageView.setDimensions(height: imageSize, width: imageSize)
        imageView.layer.cornerRadius = imageSize / 2
        
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
