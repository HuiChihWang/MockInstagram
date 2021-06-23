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
    
    // TODO: need to change operation sequence...
    static func register(with user: AuthCredentials, completion: @escaping (Error?) -> Void) {
        
        Auth.auth().createUser(withEmail: user.email, password: user.password) { result, error in
            if let error = error {
                print("Fail to upload user \(error.localizedDescription)")
                    return
            }
            
            guard let uid = result?.user.uid else {
                return
            }
            
            let data: [String: Any] = [
                "email": user.email,
                "fullName": user.fullName,
                "userName": user.userName,
                "uid": uid,
            ]
            
            Firestore.firestore().collection("users").document(uid).setData(data, completion: completion)

            if let image = user.profileImage {
                print("Ready to upload Image")
                ImageUploader.uploadImage(image: image) { url, error in
                    guard let imageURL = url else {
                        print("Cannot get download url: \(String(describing: error?.localizedDescription))")
                        return
                    }
                    
                    Firestore.firestore().collection("users").document(uid).setData(["profileImageURL": imageURL.absoluteString], merge: true, completion: completion)
                }
            }
            
        }
    }
    
    
}
