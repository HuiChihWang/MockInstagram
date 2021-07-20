//
//  ProfileHeader.swift
//  MockInstagram
//
//  Created by Hui Chih Wang on 2021/7/9.
//

import Foundation
import UIKit

protocol ProfileHeaderDelegate: AnyObject {
    func didTapOnFollowers(followers: [String])
    func didTapOnFollowings(followings: [String])
    func didChangeDisplayStyle(mode: DisplayMode)
}

class ProfileHeader: UICollectionReusableView {
    private var viewModel = ProfileHeaderViewModel()
    
    private let profileView = ProfileNameView()
    
    private let postNumber = NumberLabelView(title: "Posts")
    private let followerNumber = NumberLabelView(title: "Followers")
    private let followingNumber = NumberLabelView(title: "Followings")
    
    private var displayButtons = [UIButton]()
    
    weak var delegate: ProfileHeaderDelegate?
    
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
        gridButton.setImage(#imageLiteral(resourceName: "grid").withRenderingMode(.alwaysTemplate), for: .normal)
        let listButton = UIButton()
        listButton.setImage(#imageLiteral(resourceName: "list").withRenderingMode(.alwaysTemplate) , for: .normal)
        let savedButton = UIButton()
        savedButton.setImage(#imageLiteral(resourceName: "saved").withRenderingMode(.alwaysTemplate), for: .normal)
        
        displayButtons = [gridButton, listButton, savedButton]
        displayButtons.forEach { button in
            button.addTarget(self, action: #selector(changeDisplayStyle(_:)), for: .touchUpInside)
            button.tintColor = .black
        }
        gridButton.tintColor = .blue
        
        
        let buttonStack = UIStackView(arrangedSubviews: displayButtons)
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
        
         
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(tapOnFollowers))
        followerNumber.addGestureRecognizer(tapGesture1)
        
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(tapOnFollowings))
        followingNumber.addGestureRecognizer(tapGesture2)
    }
    
    @objc private func tapOnFollowers() {
        delegate?.didTapOnFollowers(followers: self.viewModel.user.followers)
    }
    
    @objc private func tapOnFollowings() {
        delegate?.didTapOnFollowings(followings: self.viewModel.user.followings)
    }
    
    @objc private func pressProfileButton() {
        viewModel.pressProfileButton()
    }
    
    @objc private func changeDisplayStyle(_ sender: UIButton) {
        if let index = displayButtons.firstIndex(of: sender) {
            viewModel.displayMode = DisplayMode(rawValue: index) ?? .grid
        }
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
    
    func didChangeDisplayMode(mode: DisplayMode) {
        self.delegate?.didChangeDisplayStyle(mode: mode)
        
        DispatchQueue.main.async {
            self.displayButtons.forEach { button in
                button.tintColor = .black
            }
            self.displayButtons[mode.rawValue].tintColor = .blue
        }
    }
}
