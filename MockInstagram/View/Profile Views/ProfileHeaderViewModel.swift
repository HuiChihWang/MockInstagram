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
    static let buttonBorderColor = UIColor.gray
    static let buttonBorderWidth: CGFloat = 1
    
    var user = User() {
        didSet {
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
    
    var buttonType: ButtonType {
        if user.isCurrentUser {
            return .editProfile
        }
        
        return user.isFollowed ? .following : .follow
    }
    
    func pressProfileButton() {
        print("[DEBUG] profile controller: profile button press")
        
        if !user.isCurrentUser {
            user.isFollowed.toggle()
        }
    }
}

enum ButtonType: String {
    case editProfile = "Edit Profile"
    case follow = "Follow"
    case following = "Following"
    
    var buttonBackGround: UIColor {
        switch self {
        case .follow:
            return #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        default:
            return .clear
        }
    }
    
    var buttonTextColor: UIColor {
        switch self {
        case .follow:
            return .white
        default:
            return .label
        }

    }
    
    
}
