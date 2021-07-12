//
//  ProfileController.swift
//  MockInstagram
//
//  Created by Hui Chih Wang on 2021/6/17.
//

import UIKit

class ProfileController: UICollectionViewController {
    
    private var viewModel: ProfileViewModel
    
    init(user: User) {
        viewModel = ProfileViewModel(user: user)
        super.init(collectionViewLayout: viewModel.flowLayout)
        
        viewModel.initCollectionViewCell(collectionView: collectionView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = viewModel.user.userName
    }
}

extension ProfileController {
    //TODO : fake data source here
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        18
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
        (cell as? ProfileCell)?.configure(url: "https://picsum.photos/200")
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

