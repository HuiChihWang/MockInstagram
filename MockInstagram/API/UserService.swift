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
            
            let user = User(data: data)
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
                if let user = User(data: data) {
                    users.append(user)
                }
            }
            
            completion(users)
        }
    }
}

