//
//  ProfileHeaderViewModel.swift
//  MockInstagram
//
//  Created by Hui Chih Wang on 2021/7/11.
//

import Foundation
import UIKit

protocol ProfileHeaderViewModelDelegate: AnyObject {
    func didUserInfoUpdated(user: User)
}


class ProfileHeaderViewModel {
    var user: User? {
        didSet {
            guard let user = user else {
                return
            }
            delegate?.didUserInfoUpdated(user: user)
        }
    }
    
    weak var delegate: ProfileHeaderViewModelDelegate?
    
    var postNumber: String {
        "256"
    }
    
    var followingNumber: String {
        "768"
    }
    
    var followerNumber: String {
        "100"
    }
    
    private var buttonType: ButtonType {
        .editProfile
    }
    
    static let buttonBorderColor = UIColor.gray
    static let buttonBorderWidth: CGFloat = 1
    
    
    func createButton() -> UIButton {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.setTitle(buttonType.rawValue, for: .normal)
        
        button.backgroundColor = .clear
        button.layer.borderColor = ProfileHeaderViewModel.buttonBorderColor.cgColor
        button.layer.borderWidth = ProfileHeaderViewModel.buttonBorderWidth
        
        button.addTarget(self, action: #selector(edit), for: .touchUpInside)
        return button
    }
    
    @objc private func edit() {
        print("[DEBUG] profile controller: edit button press")
    }
    
    
}

enum ButtonType: String {
    case editProfile = "Edit Profile"
    case follow = "Follow"
    case following = "Following"
}
