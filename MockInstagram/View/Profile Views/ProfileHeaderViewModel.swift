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
        "\(user.posts.count)"
    }
    
    var followingNumber: String {
        "\(user.followings.count)"
    }
    
    var followerNumber: String {
        "\(user.followers.count)"
    }
    
    var buttonType: ButtonType {
        if user.isCurrentUser {
            return .editProfile
        }
        
        return user.isFollowedByCurrentUser ? .following : .follow
    }
    
    func pressProfileButton() {
        print("[DEBUG] profile controller: profile button press")
        
        switch buttonType {
        case .editProfile:
            break
        case .follow:
            followUser()
        case .following:
            unFollowUser()
        }
    }
    
    private func followUser() {
        UserService.followUser(user: user) { error in
            if let error = error {
                print("[DEBUG] Follow Error: \(error.localizedDescription)")
                return
            }
            
            guard let currentId = AuthService.currentUser?.uid else {
                return
            }
            
            self.user.followers.append(currentId)
            
            print("[DEBUG] Follow Sucess")
            self.delegate?.didUserInfoUpdated(user: self.user)
        }
    }
    
    private func unFollowUser() {
        UserService.unfollowUser(user: user) { error in
            if let error = error {
                print("[DEBUG] UnFollow Error: \(error.localizedDescription)")
                return
            }
            
            guard let currentId = AuthService.currentUser?.uid else {
                return
            }
            
            if let index = self.user.followers.firstIndex(of: currentId) {
                self.user.followers.remove(at: index)
            }
            
            print("[DEBUG] UnFollow Sucess")
            self.delegate?.didUserInfoUpdated(user: self.user)
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
