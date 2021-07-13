//
//  FeedController.swift
//  MockInstagram
//
//  Created by Hui Chih Wang on 2021/6/17.
//

import UIKit

class FeedController: UICollectionViewController {
    private let viewModel = FeedControllerViewModel()
    
    weak var authDelegate: AuthenticationDelegate?
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        super.init(collectionViewLayout: layout)
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureRefreshController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchPage()
    }
    
    @objc private func refreshPage() {
        viewModel.fetchPage()
    }
    
    private func configureUI() {
        collectionView.register(PostViewCell.self, forCellWithReuseIdentifier: "\(PostViewCell.self)")
        collectionView.backgroundColor = .clear
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(logOut))
    }
    
    private func configureRefreshController() {
        let controller = UIRefreshControl()
        controller.addTarget(self, action: #selector(refreshPage), for: .valueChanged)
        collectionView.refreshControl = controller
    }
    
    @objc private func logOut() {
        authDelegate?.didLogout()
    }
}


extension FeedController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.posts.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(PostViewCell.self)", for: indexPath) as? PostViewCell
        
        cell?.post = viewModel.posts[indexPath.item]
        
        return cell ?? UICollectionViewCell()
    }
}

extension FeedController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 700)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}

extension FeedController: FeedControllerViewModelDelegate {
    func didUpdatePosts() {
        DispatchQueue.main.async {
            self.navigationItem.title = self.viewModel.currentUser.userName
            self.collectionView.reloadData()
            self.collectionView.refreshControl?.endRefreshing()
        }
    }
}



