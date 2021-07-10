//
//  UserService.swift
//  MockInstagram
//
//  Created by Hui Chih Wang on 2021/7/10.
//

import Foundation
import Firebase

struct UserService {
    static let userCollections = Firestore.firestore().collection("users")
    
    static func fetchUser(completion: @escaping (User?) -> Void) {
        guard let uid = AuthService.currentUser?.uid else {
            return
        }
        
        userCollections.document(uid).getDocument { snapshot, error in
            guard let data = snapshot?.data() else {
                completion(nil)
                return
            }
            guard let email = data["email"] as? String,
                  let fullName = data["fullName"] as? String,
                  let userName = data["userName"] as? String,
                  let uid = data["uid"] as? String
            else {
                completion(nil)
                return
            }
            
            var user = User(email: email, fullName: fullName, userName: userName, uid: uid)
            user.imageUrl = data["imageUrl"] as? String
            
            completion(user)
        }
    }
}
