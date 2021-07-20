//
//  User.swift
//  MockInstagram
//
//  Created by Hui Chih Wang on 2021/7/10.
//

import Foundation

struct User {
    var email: String = "test@gmail.com"
    var fullName: String = "testName"
    var userName: String = "testAccount"
    var uid: String = "12344667"
    var imageUrl: String?
    
    var isCurrentUser: Bool {
        AuthService.currentUser?.uid == uid
    }
    
    var isFollowedByCurrentUser: Bool {
        guard let currentId = AuthService.currentUser?.uid else {
            return false
        }
        
        return followers.contains(currentId)
    }
    
    var followings = [String]()
    var followers = [String]()
    var posts = [String]()
    var savedPosts = [String]()
    
    init() {
    }
    
    init?(data: [String: Any]) {
        guard let email = data["email"] as? String,
              let fullName = data["fullName"] as? String,
              let userName = data["userName"] as? String,
              let uid = data["uid"] as? String
        else {
            return nil
        }
        
        self.email = email
        self.userName = userName
        self.fullName = fullName
        self.uid = uid
        
        self.imageUrl = data["imageUrl"] as? String
        self.followings = data["followings"] as? [String] ?? []
        self.followers = data["followers"] as? [String] ?? []
        self.posts = data["posts"] as? [String] ?? []
        self.savedPosts = data["saves"] as? [String] ?? []
    }
}
