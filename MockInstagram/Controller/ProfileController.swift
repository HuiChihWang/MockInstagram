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
        
        super.init(collectionViewLayout: viewModel.flowLayout)
        viewModel.delegate = self
        viewModel.initCollectionViewCell(collectionView: collectionView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchPage()
    }
}

extension ProfileController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.user.posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let view  = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(ProfileHeader.self)", for: indexPath) as? ProfileHeader else {
            return UICollectionReusableView()
        }
        
        view.configureUser(user: viewModel.user)
        return view
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ProfileCell.self)", for: indexPath)
        
        let postId = viewModel.user.posts[indexPath.item]
        
        PostService.fetchPost(by: postId) { post in
            guard let postUrl = post?.photoUrl else {
                return
            }
            (cell as? ProfileCell)?.configure(url: postUrl)
        }
        
        return cell
    }
}

extension ProfileController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = viewModel.getPhotoSize(gridWidth: collectionView.frame.width)
        return CGSize(width: itemSize, height: itemSize)
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
            self.collectionView.reloadData()
        }
    }
}

