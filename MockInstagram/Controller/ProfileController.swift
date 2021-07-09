//
//  ProfileController.swift
//  MockInstagram
//
//  Created by Hui Chih Wang on 2021/6/17.
//

import UIKit

class ProfileController: UICollectionViewController {
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        
        super.init(collectionViewLayout: layout)
        
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: "\(ProfileCell.self)")
        
        collectionView.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(ProfileHeader.self)")
        collectionView.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}


extension ProfileController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        18
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view  = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(ProfileHeader.self)", for: indexPath)
        return view
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ProfileCell.self)", for: indexPath)
        (cell as? ProfileCell)?.configure()
        return cell
    }
}

extension ProfileController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return .zero
        }
        
        let horizontalSpacing = layout.minimumInteritemSpacing
        let numberPerRow = 3
        let width = collectionView.frame.width
        let itemSize = (width - horizontalSpacing * CGFloat(numberPerRow - 1)) / CGFloat(numberPerRow)
        
        return CGSize(width: itemSize, height: itemSize)
    }
        
func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width, height: 240)
    }


}

