//
//  PostViewCell.swift
//  MockInstagram
//
//  Created by Hui Chih Wang on 2021/6/17.
//

import UIKit

class PostViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.borderWidth = 2
        createStackToHandleCommentRegion()
        createSaveButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        accountImageView.image = #imageLiteral(resourceName: "venom-7")
        accountName.setTitle("hui_chih", for: .normal)
        
        postImageView.image = #imageLiteral(resourceName: "venom-7")
    }
    
    private func createStackToHandleCommentRegion() {
        let buttonsStack = UIStackView()
        buttonsStack.axis = .horizontal
        buttonsStack.spacing = 15
        let buttons = [likeButton, messageButton, shareButton]
        
        buttons.forEach { button in
            button.isUserInteractionEnabled = true
            button.contentMode = .scaleAspectFill
            button.setDimensions(height: 25, width: 25)
            buttonsStack.addArrangedSubview(button)
            
        }
        
        contentView.addSubview(buttonsStack)
        buttonsStack.anchor(top: postImageView.bottomAnchor, left: contentView.leftAnchor, paddingTop: 15, paddingLeft: 10)
    }
    
    private func createSaveButton() {
        contentView.addSubview(saveButton)
        saveButton.anchor(top: postImageView.bottomAnchor, right: rightAnchor, paddingTop: 15, paddingRight: 10)
        
    }
    
    private lazy var accountImageView: UIImageView = {
        let accountImageView = UIImageView()
        accountImageView.contentMode = .scaleAspectFill
        
        contentView.addSubview(accountImageView)
        
        let width: CGFloat = 50
        accountImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 10, paddingLeft: 10, width: width, height: width)
        
        accountImageView.layer.cornerRadius = width / 2
        accountImageView.clipsToBounds = true
        
        return accountImageView
    }()
    
    private lazy var postImageView: UIImageView = {
        let postImageView = UIImageView()
        
        contentView.addSubview(postImageView)
        postImageView.setDimensions(height: frame.width, width: frame.width)
        postImageView.centerX(inView: contentView, topAnchor: accountImageView.bottomAnchor, paddingTop: 10)
        
        postImageView.contentMode = .scaleAspectFill
        
        return postImageView
    }()
    
    private lazy var accountName: UIButton = {
        let nameButton = UIButton()
        contentView.addSubview(nameButton)
        nameButton.centerY(inView: accountImageView, leftAnchor: accountImageView.rightAnchor, paddingLeft: 15)
        nameButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        nameButton.setTitleColor(.black, for: .normal)
        return nameButton
    }()
    

    
    
    private let likeButton: UIImageView = {
        let likeButtonView = UIImageView()
        likeButtonView.image = UIImage(named: "like_unselected")
        return likeButtonView
    }()

    private let messageButton: UIImageView = {
        let msgButtonView = UIImageView()
        msgButtonView.image = UIImage(named: "comment")
        return msgButtonView
    }()
    
    private let shareButton: UIImageView = {
        let shareButtonView = UIImageView()
        shareButtonView.image = UIImage(named: "send2")
        return shareButtonView
    }()
    
    private let saveButton: UIImageView = {
        let saveButton = UIImageView()
        saveButton.image = UIImage(named: "ribbon")
        
        saveButton.isUserInteractionEnabled = true
        saveButton.contentMode = .scaleAspectFill
        saveButton.setDimensions(height: 25, width: 25)

        return saveButton
        
    }()
    
//    private let saveButton = {
//
//    }()
//
//    private let moreButton = {
//
//    }()

}
