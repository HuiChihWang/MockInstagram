//
//  PostViewCellViewModel.swift
//  MockInstagram
//
//  Created by Hui Chih Wang on 2021/7/13.
//

import Foundation
import UIKit

protocol PostViewCellViewModelDelegate: AnyObject {
    func didUserFetched(user: User)
    func didPostLikeStatusChanged()
    func didPostSaveStatusChanged(isSaved: Bool)
}

class PostViewCellViewModel {
    private weak var delegate: PostViewCellViewModelDelegate?
    private var post: Post
    private var saved: Bool = false
    
    var savedButtonImage: UIImage? {
        return saved ? UIImage(named: "ribbon-fill")?.withRenderingMode(.alwaysTemplate) : UIImage(named: "ribbon")
    }
    
    var likeButtonImage: UIImage {
        return post.isLikedByCurrentUser ? #imageLiteral(resourceName: "like_selected").withRenderingMode(.alwaysTemplate) : #imageLiteral(resourceName: "like_unselected")
    }
    
    var likeLabel: String {
        "\(post.likes.count) Likes"
    }
    
    var photoUrl: String {
        post.photoUrl
    }
    
    var dateLabel: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        return dateFormatter.string(from: post.date)
    }
    
    
    init(post: Post, delegate: PostViewCellViewModelDelegate? = nil) {
        self.post = post
        self.delegate = delegate
        UserService.fetchUser(with: post.ownerUid) { user in
            guard let user = user else {
                print("[DEBUG] cannot fetch user from post")
                return
            }
            self.delegate?.didUserFetched(user: user)
        }
        
        post.checkIsPhotoSavedByCurrentUser { saved in
            self.saved = saved
            self.delegate?.didPostSaveStatusChanged(isSaved: saved)
        }
    }
    
    func likePhoto() {
        print("[DEBUG] Post View Cell VM => You like this photo")
        guard let userId = AuthService.currentUser?.uid else {
            return
        }
        
        if post.isLikedByCurrentUser {
            if let index = post.likes.firstIndex(of: userId) {
                post.likes.remove(at: index)
            }
            
            PostService.unlikePost(pid: post.pid) { error in
                self.delegate?.didPostLikeStatusChanged()
            }
            
        } else {
            if !post.likes.contains(userId) {
                self.post.likes.append(userId)
            }
            
            PostService.likePost(pid: post.pid) { error in
                self.delegate?.didPostLikeStatusChanged()
            }
        }
    }
    
    func savePhoto() {
        self.saved.toggle()
        post.checkIsPhotoSavedByCurrentUser { saved in
            let saveIntention = saved ? PostService.removeSavedPost : PostService.savePost
            let debugStr = saved ? "unsave" : "save"
            
            saveIntention(self.post.pid) { error in
                if let error = error {
                    print("[DEBUG] \(debugStr) post fail: \(error.localizedDescription)")
                    return
                }
                print("[DEBUG] \(debugStr) post success")
                self.delegate?.didPostSaveStatusChanged(isSaved: !saved)
            }
        }
    }
}
