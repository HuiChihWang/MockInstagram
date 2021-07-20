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
            completion(nil)
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
    
    static func followUser(user: User, completion: @escaping FirebaseCompletion) {
        guard let currentUser = AuthService.currentUser,
              user.uid != currentUser.uid else {
            return
        }
        
        userCollections.document(user.uid).updateData([
            "followers": FieldValue.arrayUnion([currentUser.uid])
        ]) { error in
            if let error = error {
                completion(error)
                return
            }
            
            userCollections.document(currentUser.uid).updateData([
                "followings": FieldValue.arrayUnion([user.uid])
            ], completion: completion)
        }
    }
    
    static func unfollowUser(user: User, completion: @escaping FirebaseCompletion) {
        guard let currentUser = AuthService.currentUser,
              user.uid != currentUser.uid else {
            return
        }
        
        userCollections.document(user.uid).updateData([
            "followers": FieldValue.arrayRemove([currentUser.uid])
        ]) { error in
            if let error = error {
                completion(error)
                return
            }
            
            userCollections.document(currentUser.uid).updateData([
                "followings": FieldValue.arrayRemove([user.uid])
            ], completion: completion)
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
    
    static func fetchUser(with id: String, completion: @escaping (User?) -> Void) {
        userCollections.document(id).getDocument { querySnapShot, error in
            
            guard let data = querySnapShot?.data() else {
                print("[DEBUG] fetch user: Error occur")
                completion(nil)
                return
            }
            
            guard let user = User(data: data) else {
                print("[DEBUG] fetch user: Create user fail")
                completion(nil)
                return
            }
            
            completion(user)
        }
    }
    
    static func fetchUsers(with requests: [String], completion: @escaping ([User]) -> Void) {
        var users = [User]()
        fetchAllUsers { allUsers in
            users = allUsers.filter({ user in
                requests.contains(user.uid)
            })
            completion(users)
        }
        
        let group = DispatchGroup()
        
        requests.forEach { request in
            fetchUser(with: request) { user in
                DispatchQueue.global().async(group: group) {
                    guard let user = user else {
                        return
                    }
                    users.append(user)
                }
            }
        }
    }
}

