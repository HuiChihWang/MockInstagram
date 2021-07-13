//
//  AuthService.swift
//  MockInstagram
//
//  Created by Hui Chih Wang on 2021/6/23.
//

import Foundation
import UIKit
import Firebase

struct AuthCredentials {
    let email: String
    let password: String
    let fullName: String
    let userName: String
    var profileImage: UIImage?
}

class AuthService {
    static let profileImageFolder = "profile_images"
    
    static var currentUser: Firebase.User? {
        return Auth.auth().currentUser
    }
    
    static func logIn(email: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    static func logOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("[DEBUG] Fail to sign out")
        }
    }
    
    static private func createAccount(user: AuthCredentials, completion: @escaping (String?, Error?) -> Void) {
                
        Auth.auth().createUser(withEmail: user.email, password: user.password) { result, error in
            guard let uid = result?.user.uid else {
                completion(nil, error)
                return
            }

            let data: [String: Any] = [
                "email": user.email,
                "fullName": user.fullName,
                "userName": user.userName,
                "uid": uid,
            ]

            UserService.userCollections.document(uid).setData(data) { error in
                completion(uid, error)
            }
        }
    }
    
    // first create account, then upload image
    static func register(with user: AuthCredentials, completion: @escaping (Error?) -> Void) {
        
        createAccount(user: user) { uid, error in
            
            guard let id = uid, error == nil else {
                completion(error)
                return
            }
            
            guard let image = user.profileImage else {
                completion(error)
                return
            }
        
            ImageUploader.uploadImage(image: image, destination: profileImageFolder) { url, error in
                guard let imageUrl = url else {
                    completion(error)
                    return
                }
                
                UserService.userCollections.document(id).setData(
                    ["imageUrl": imageUrl.absoluteString],
                    merge: true,
                    completion: completion
                )
            }
            
        }
    }
}
