//
//  Post.swift
//  MockInstagram
//
//  Created by Hui Chih Wang on 2021/7/12.
//

import Foundation
import Firebase
struct Post {
    let photoUrl: String
    let description: String
    
    let ownerUid: String
    let date: Date
    
    let pid: String
    
    var likes = [String]()
    
    var isLikedByCurrentUser: Bool {
        guard let userId = AuthService.currentUser?.uid else {
            return false
        }
        
        return likes.contains(userId)
    }
    
    func checkIsPhotoSavedByCurrentUser(completion: @escaping (Bool) -> Void) {
        UserService.fetchCurrentUser { user in
            guard let user = user else {
                completion(false)
                return
            }
            
            completion(user.savedPosts.contains(pid))
        }
    }
    
    init?(data: [String: Any]) {
        guard let pid = data["pid"] as? String,
              let url = data["photoUrl"] as? String ,
              let description = data["description"] as? String,
              let ownerUid = data["owner"] as? String,
              let date = (data["date"] as? Timestamp)?.dateValue()
        else {
            print("Post Constructor: Construct Fail")
            return nil
        }
        
        self.photoUrl = url
        self.description = description
        self.ownerUid = ownerUid
        self.date = date
        self.pid = pid
        self.likes = data["likes"] as? [String] ?? []
    }
}
