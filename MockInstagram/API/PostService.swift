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
    static let postImageFolder = "post_images"
    
    static let postCollections = Firestore.firestore().collection("posts")
    
    static func uploadPost(description: String, photo: UIImage, completion: @escaping FirebaseCompletion) {
        
        guard let currentUser = AuthService.currentUser else {
            completion(nil)
            return
        }
        
        ImageUploader.uploadImage(image: photo, destination: postImageFolder) { url, error in
            guard let photoUrl = url else {
                completion(error)
                return
            }
            
            let data: [String : Any] = [
                "photoUrl": photoUrl.absoluteString,
                "description": description,
                "date": Timestamp(date: Date()),
                "owner": currentUser.uid
            ]
            
            var postRef: DocumentReference?
            postRef = postCollections.addDocument(data: data) { error in
                if let error = error {
                    completion(error)
                    return
                }
                
                postCollections.document(postRef!.documentID).setData(
                    ["pid": postRef!.documentID],
                    merge: true) { error in
                    if let error = error {
                        completion(error)
                        return
                    }

                    let userData = ["posts": FieldValue.arrayUnion([postRef!.documentID])]
                    UserService.userCollections.document(currentUser.uid).updateData(userData, completion: completion)
                }
            }
        }
    }
    
    static func fetchAllPost(completion: @escaping ([Post]) -> Void) {
        postCollections.getDocuments { querySnapShot, error in
            var  posts = [Post]()
            guard  let query = querySnapShot else {
                print("[DEBUG] fetch all users error")
                completion(posts)
                return
            }
            
            query.documents.forEach { doc in
                let data = doc.data()
                if let post = Post(data: data) {
                    posts.append(post)
                }
            }
            
            completion(posts)
        }
    }
    
    
    //TODO: think how to use diapatch queue to execute 10 asynchronous requests
    static func fetchPosts(of userId: String, completion: @escaping ([Post]) -> Void) {
        fetchAllPost { allPosts in
            let posts = allPosts.filter { post in
                return post.ownerUid == userId
            }
            completion(posts)
        }
    }
    
    static func fetchPost(by pid: String, completion: @escaping (Post?) -> Void) {
        postCollections.document(pid).getDocument { query, error in
            guard let data = query?.data(),
                  let post = Post(data: data)
            else {
                completion(nil)
                return
            }
            
            completion(post)
        }
    }
    
    static func likePost(pid: String, completion: @escaping FirebaseCompletion) {
        guard let currentUser = AuthService.currentUser else {
            return
        }
        
        postCollections.document(pid).updateData(
            ["likes": FieldValue.arrayUnion([currentUser.uid])],
            completion: completion
        )
    }
    
    static func unlikePost(pid: String, completion: @escaping FirebaseCompletion) {
        guard let currentUser = AuthService.currentUser else {
            return
        }
        
        postCollections.document(pid).updateData(
            ["likes": FieldValue.arrayRemove([currentUser.uid])],
            completion: completion
        )
    }
    
    
}
