//
//  ProfileViewModel.swift
//  MockInstagram
//
//  Created by Hui Chih Wang on 2021/7/11.
//

import Foundation
import UIKit

struct ProfileViewModel {
    
    let user: User
    let flowLayout = UICollectionViewFlowLayout()
    
    init(user: User) {
        self.user = user
        initCollectionViewLayout()
    }
    
    func initCollectionViewCell(collectionView: UICollectionView) {
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: "\(ProfileCell.self)")
        
        collectionView.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(ProfileHeader.self)")
        
        collectionView.backgroundColor = backgroundColor
    }
    
    private func initCollectionViewLayout() {
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = photoSpacing.horizontal
        flowLayout.minimumLineSpacing = photoSpacing.vertical
    }
    
    private var photoSpacing: (horizontal: CGFloat, vertical: CGFloat) {
        return (1, 1)
    }
    
    private var numberOfPhotosPerRow = 3
    
    var backgroundColor = UIColor.white
    
    var headerHeight: CGFloat = 240
    
    func getPhotoSize(gridWidth: CGFloat) -> CGFloat {
        let horizontalSpacing = photoSpacing.horizontal
        let itemSize = (gridWidth - horizontalSpacing * CGFloat(numberOfPhotosPerRow - 1)) / CGFloat(numberOfPhotosPerRow)
        
        return itemSize
    }
}
