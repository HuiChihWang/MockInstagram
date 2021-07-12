//
//  ProfileHeader.swift
//  MockInstagram
//
//  Created by Hui Chih Wang on 2021/7/9.
//

import Foundation
import UIKit

class ProfileHeader: UICollectionReusableView {
    private var viewModel = ProfileHeaderViewModel()
    
    private let profileView = ProfileNameView()
    
    private let postNumber = NumberLabelView(title: "Posts")
    private let followerNumber = NumberLabelView(title: "Followers")
    private let followingNumber = NumberLabelView(title: "Followings")
    
    private let profileButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        button.titleLabel?.textAlignment = .center
        button.layer.borderColor = ProfileHeaderViewModel.buttonBorderColor.cgColor
        button.layer.borderWidth = ProfileHeaderViewModel.buttonBorderWidth
        button.layer.cornerRadius = 3
        
        button.addTarget(self, action: #selector(pressProfileButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewModel.delegate = self
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUser(user: User) {
        viewModel.user = user
    }

    private func configureUI() {
        addSubview(profileView)
        profileView.anchor(top: self.topAnchor, left: self.leftAnchor, paddingTop: 20, paddingLeft: 20, width: 100, height: 110)
        
        createInfoLabels()
        createListButtons()
        
        addSubview(profileButton)
        profileButton.centerX(inView: self, topAnchor: profileView.bottomAnchor, paddingTop: 20)
        profileButton.setDimensions(height: 30, width: frame.width * 0.95)
        
        postNumber.text = viewModel.postNumber
        followingNumber.text = viewModel.followingNumber
        followerNumber.text = viewModel.followerNumber
    
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
        
        buttonStack.layer.borderColor = ProfileHeaderViewModel.buttonBorderColor.cgColor
        buttonStack.layer.borderWidth = ProfileHeaderViewModel.buttonBorderWidth
    }
    
    private func createInfoLabels() {
        let stack = UIStackView(arrangedSubviews: [postNumber, followerNumber, followingNumber])

        stack.axis = .horizontal
        stack.distribution = .fillEqually
        addSubview(stack)
        
        stack.anchor(top: self.topAnchor, left: profileView.rightAnchor, right: self.rightAnchor, paddingTop: 40, paddingLeft: 20, paddingRight: 20)
    }
    
    @objc private func pressProfileButton() {
        viewModel.pressProfileButton()
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

extension ProfileHeader: ProfileHeaderViewModelDelegate {
    func didUserInfoUpdated(user: User) {
        DispatchQueue.main.async {
            self.postNumber.text = self.viewModel.postNumber
            self.followingNumber.text = self.viewModel.followingNumber
            self.followerNumber.text = self.viewModel.followerNumber
            
            self.profileButton.setTitle(self.viewModel.buttonType.rawValue, for: .normal)
            self.profileButton.setTitleColor(self.viewModel.buttonType.buttonTextColor, for: .normal)
            self.profileButton.backgroundColor = self.viewModel.buttonType.buttonBackGround
            
            self.profileView.nameLabelText = user.fullName
            if let url = user.imageUrl {
                self.profileView.setImageURL(url: url)
            }
        }
    }
}
