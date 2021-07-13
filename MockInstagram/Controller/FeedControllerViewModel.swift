//
//  FeedControllerViewModel.swift
//  MockInstagram
//
//  Created by Hui Chih Wang on 2021/7/13.
//

import Foundation

protocol FeedControllerViewModelDelegate: AnyObject {
    func didUpdatePosts()
}

class FeedControllerViewModel {
    weak var delegate: FeedControllerViewModelDelegate?
    
    private(set) var posts = [Post]()
    
    private(set) var currentUser = User()
    
    func fetchPage() {
        UserService.fetchCurrentUser { user in
            guard let user = user else {
                return
            }
            self.currentUser = user
            
            PostService.fetchAllPost { posts in
                self.posts = posts
                self.delegate?.didUpdatePosts()
            }
        }
    }
}
