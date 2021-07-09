//
//  ProfileHeader.swift
//  MockInstagram
//
//  Created by Hui Chih Wang on 2021/7/9.
//

import Foundation
import UIKit

class ProfileHeader: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        profileImageView.image = #imageLiteral(resourceName: "venom-7")
        addSubview(profileImageView)
        
        profileImageView.anchor(top: self.topAnchor, left: self.leftAnchor, paddingTop: 20, paddingLeft: 20)
        
        profileName.text = "Gilbert Wang"
        addSubview(profileName)
        
        profileName.centerX(inView: profileImageView, topAnchor: profileImageView.bottomAnchor, paddingTop: 10)
        
        
        createInfoLabels()
        postNumber.text = "256"
        followingNumber.text = "768"
        followerNumber.text = "100"
    
        createListButtons()
        
        addSubview(editButton)
        editButton.centerX(inView: self, topAnchor: profileName.bottomAnchor, paddingTop: 20)
        editButton.setDimensions(height: 25, width: frame.width * 0.95)
        editButton.addTarget(self, action: #selector(edit), for: .touchUpInside)
    }
    
    @objc private func edit() {
        print("[DEBUG] profile controller: edit button press")
    }
    
    @objc private func showGridPhotos() {
        print("[DEBUG] profile controller: show Grid Photos")
    }
    
    @objc private func showListPhotos() {
        print("[DEBUG] profile controller: show List Photos")
    }
    
    @objc private func showSavedPhotos() {
        print("[DEBUG] profile controller: show Saved Photos")
    }
    
    private func createListButtons() {
        let gridButton = UIButton()
        gridButton.setImage(#imageLiteral(resourceName: "grid"), for: .normal)
        gridButton.addTarget(self, action: #selector(showGridPhotos), for: .touchUpInside)
        let listButton = UIButton()
        listButton.setImage(#imageLiteral(resourceName: "list") , for: .normal)
        listButton.addTarget(self, action: #selector(showListPhotos), for: .touchUpInside)
        let savedButton = UIButton()
        savedButton.addTarget(self, action: #selector(showSavedPhotos), for: .touchUpInside)
        savedButton.setImage(#imageLiteral(resourceName: "ribbon"), for: .normal)
        
        let buttonStack = UIStackView(arrangedSubviews: [gridButton, listButton, savedButton])
        
        buttonStack.tintColor = .blue
        buttonStack.axis = .horizontal
        buttonStack.distribution = .fillEqually
        
        addSubview(buttonStack)
        buttonStack.setWidth(frame.width)
        buttonStack.setHeight(40)
        buttonStack.centerX(inView: self)
        buttonStack.anchor(bottom: self.bottomAnchor)
        
        buttonStack.layer.borderColor = UIColor.gray.cgColor
        buttonStack.layer.borderWidth = 1
        
        
    }
    
    
    
    private func createInfoLabels() {
        
        let postInfo = createInfoLabel(title: "Posts")
        let followerInfo = createInfoLabel(title: "Followers")
        let followingInfo = createInfoLabel(title: "Followings")
        
        postNumber = postInfo.arrangedSubviews[0] as! UILabel
        followerNumber = followerInfo.arrangedSubviews[0] as! UILabel
        followingNumber = followingInfo.arrangedSubviews[0] as! UILabel
        
        let stack = UIStackView(arrangedSubviews: [postInfo, followerInfo, followingInfo])

        stack.axis = .horizontal
        stack.distribution = .fillEqually
        addSubview(stack)
        
        stack.centerY(inView: profileImageView)
        stack.anchor(left: profileImageView.rightAnchor, right: self.rightAnchor, paddingLeft: 20, paddingRight: 20)
    }
    
    private func createInfoLabel(title: String) -> UIStackView {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textAlignment = .center
        titleLabel.textColor = .gray
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        
        let stack = UIStackView(arrangedSubviews: [label, titleLabel])
        stack.axis = .vertical
        stack.spacing = 5
        
        return stack
    }
    
    private var postNumber: UILabel!
    private var followerNumber: UILabel!
    private var followingNumber: UILabel!
    
    private let editButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Edit Profile", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.textAlignment = .center
        
        button.backgroundColor = .clear
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        let imageSize: CGFloat = 80
        imageView.setDimensions(height: imageSize, width: imageSize)
        imageView.layer.cornerRadius = imageSize / 2
        
        return imageView
    }()
    
    private let profileName: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    
    
}
