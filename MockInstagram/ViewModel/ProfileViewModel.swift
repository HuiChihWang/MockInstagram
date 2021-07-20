//
//  ProfileViewModel.swift
//  MockInstagram
//
//  Created by Hui Chih Wang on 2021/7/11.
//

import Foundation
import UIKit

protocol ProfileViewModelDelegate: AnyObject {
    func didPostsUpdate()
    func didUserUpdate()
}

class ProfileViewModel {
    
    let userId: String
    var displayMode: DisplayMode = .grid
    
    private(set) var user = User() {
        didSet {
            delegate?.didUserUpdate()
        }
    }
    
    var data: [String] {
        displayMode == .save ? user.savedPosts : user.posts
    }
    
    var cellIdentifier: String {
        displayMode == .grid ? "\(ProfileCell.self)" : "\(PostViewCell.self)"
    }
    
    weak var delegate: ProfileViewModelDelegate?
    
    init(userId: String) {
        self.userId = userId
        fetchPage()
    }
    
    func fetchPage() {
        UserService.fetchUser(with: userId) { user in
            if let user = user {
                self.user = user
            }
        }
    }
    
    var photoSpacing: (horizontal: CGFloat, vertical: CGFloat) {
        return (1, 1)
    }
    
    private var numberOfPhotosPerRow = 3
    
    var backgroundColor = UIColor.white
    
    var headerHeight: CGFloat = 240
    
    func getCellSize(gridWidth: CGFloat, displayMode: DisplayMode = .grid) -> CGSize {
        switch displayMode {
        case .grid:
            let horizontalSpacing = photoSpacing.horizontal
            let itemSize = (gridWidth - horizontalSpacing * CGFloat(numberOfPhotosPerRow - 1)) / CGFloat(numberOfPhotosPerRow)
            return CGSize(width: itemSize, height: itemSize)
        default:
            return CGSize(width: gridWidth, height: 700)
        }
    }
}
