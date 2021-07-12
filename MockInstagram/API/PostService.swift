//
//  PostService.swift
//  MockInstagram
//
//  Created by Hui Chih Wang on 2021/7/12.
//

import Foundation
import UIKit
import Firebase

typealias FirebaseCompletion = (Error?) -> Void

struct PostService {
    static let postCollections = Firestore.firestore().collection("posts")
    
    static func uploadPost(description: String, photo: UIImage, completion: @escaping FirebaseCompletion) {
        
        guard let currentUser = AuthService.currentUser else {
            completion(nil)
            return
        }
        
        ImageUploader.uploadImage(image: photo) { url, error in
            guard let photoUrl = url else {
                completion(error)
                return
            }
            
            let data: [String : Any] = [
                "photoUrl": photoUrl.absoluteString,
                "description": description,
                "date": Timestamp(date: Date()),
                "likes": 0,
                "owner": currentUser.uid
            ]
            
//            postCollections.addDocument(data: data) { error in
//                <#code#>
//            }
            
        }
        
    }
}
