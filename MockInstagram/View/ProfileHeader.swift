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
    
    var user: User? {
        didSet {
            profileView.nameLabelText = user?.fullName
            if let imageUrl = user?.imageUrl {
                profileView.setImageURL(url: imageUrl)
            }
        }
    }
    
    private func configureUI() {
        addSubview(profileView)
        profileView.anchor(top: self.topAnchor, left: self.leftAnchor, paddingTop: 20, paddingLeft: 20, width: 100, height: 110)
        
        
        createInfoLabels()
        postNumber.text = "256"
        followingNumber.text = "768"
        followerNumber.text = "100"
    
        createListButtons()
        
        addSubview(editButton)
        editButton.centerX(inView: self, topAnchor: profileView.bottomAnchor, paddingTop: 20)
        editButton.setDimensions(height: 30, width: frame.width * 0.95)
        editButton.addTarget(self, action: #selector(edit), for: .touchUpInside)
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
        let stack = UIStackView(arrangedSubviews: [postNumber, followerNumber, followingNumber])

        stack.axis = .horizontal
        stack.distribution = .fillEqually
        addSubview(stack)
        
        stack.anchor(top: self.topAnchor, left: profileView.rightAnchor, right: self.rightAnchor, paddingTop: 40, paddingLeft: 20, paddingRight: 20)
    }
    
    private let postNumber = NumberLabelView(title: "Posts")
    private let followerNumber = NumberLabelView(title: "Followers")
    private let followingNumber = NumberLabelView(title: "Followings")
    
    private let profileView = ProfileView()
    
    private let editButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Edit Profile", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.textAlignment = .center
        
        button.backgroundColor = .clear
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    
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
}
