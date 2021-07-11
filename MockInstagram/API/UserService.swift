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
    
    static func fetchCurrentUser(completion: @escaping (User?) -> Void) {
        guard let uid = AuthService.currentUser?.uid else {
            return
        }
        
        userCollections.document(uid).getDocument { document, error in
            guard let data = document?.data() else {
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
    
    static func fetchAllUsers(completion: @escaping ([User]) -> Void) {
        userCollections.getDocuments { querySnapShot, error in
            var users = [User]()

            guard  let query = querySnapShot else {
                print("[DEBUG] fetch all users error")
                completion(users)
                return
            }

            query.documents.forEach { doc in
                let data = doc.data()
                
                guard let email = data["email"] as? String,
                      let fullName = data["fullName"] as? String,
                      let userName = data["userName"] as? String,
                      let uid = data["uid"] as? String
                else {
                    return
                }
                
                let user = User(email: email, fullName: fullName, userName: userName, uid: uid, imageUrl: data["imageUrl"] as? String)
                
                users.append(user)
            }
            
            completion(users)
        }
    }
}

