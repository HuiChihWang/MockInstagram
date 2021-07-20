//
//  ProfileController.swift
//  MockInstagram
//
//  Created by Hui Chih Wang on 2021/6/17.
//

import UIKit

class ProfileController: UICollectionViewController {
    private let viewModel: ProfileViewModel
    
    init(userID: String) {
        viewModel = ProfileViewModel(userId: userID)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = viewModel.photoSpacing.horizontal
        layout.minimumLineSpacing = viewModel.photoSpacing.vertical
        super.init(collectionViewLayout: layout)
        
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: "\(ProfileCell.self)")
        
        collectionView.register(PostViewCell.self, forCellWithReuseIdentifier: "\(PostViewCell.self)")
        
        collectionView.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(ProfileHeader.self)")
        
        collectionView.backgroundColor = viewModel.backgroundColor
        
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureReshshController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchPage()
    }
    
    private func configureReshshController() {
        let refreshController = UIRefreshControl()
        refreshController.addTarget(self, action: #selector(refreshPage), for: .valueChanged)
        collectionView.refreshControl = refreshController
    }
    
    @objc private func refreshPage() {
        viewModel.fetchPage()
    }
}

extension ProfileController {
    //TODO: Reorder the posts by date
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.user.posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let view  = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(ProfileHeader.self)", for: indexPath) as? ProfileHeader else {
            return UICollectionReusableView()
        }
        
        view.configureUser(user: viewModel.user)
        view.delegate = self
        return view
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellId = viewModel.displayMode == .grid ? "\(ProfileCell.self)" : "\(PostViewCell.self)"
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        let postId = viewModel.user.posts[indexPath.item]
        PostService.fetchPost(by: postId) { post in
            guard let post = post else {
                return
            }
            
            if self.viewModel.displayMode == .grid {
                
                (cell as? ProfileCell)?.configure(url: post.photoUrl)
                
            } else {
                (cell as? PostViewCell)?.viewModel = PostViewCellViewModel(post: post)
            }
        }
        
        return cell
    }
}

extension ProfileController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.getCellSize(gridWidth: collectionView.frame.width, displayMode: viewModel.displayMode)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width, height: viewModel.headerHeight)
    }
}

extension ProfileController: ProfileViewModelDelegate {
    func didPostsUpdate() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func didUserUpdate() {
        DispatchQueue.main.async {
            self.navigationItem.title = self.viewModel.user.userName
            self.collectionView.refreshControl?.endRefreshing()
            self.collectionView.reloadData()
        }
    }
}

extension ProfileController: ProfileHeaderDelegate {
    func didTapOnFollowings(followings: [String]) {
        let usersController = UsersTableViewController()
        usersController.navigationItem.title = "Followings"
        usersController.userIds = followings
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(usersController, animated: true)
        }
    }
    
    func didTapOnFollowers(followers: [String]) {
        let usersController = UsersTableViewController()
        usersController.navigationItem.title = "Followers"
        usersController.userIds = followers
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(usersController, animated: true)
        }
    }
    
    func didChangeDisplayStyle(mode: DisplayMode) {
        print("[DEBUG] profile controller: change display mode to \(mode.rawValue)")
        viewModel.displayMode = mode
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
    }
}

