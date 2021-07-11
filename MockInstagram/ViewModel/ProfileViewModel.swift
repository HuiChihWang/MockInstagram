//
//  ProfileViewModel.swift
//  MockInstagram
//
//  Created by Hui Chih Wang on 2021/7/11.
//

import Foundation
import UIKit

struct ProfileViewModel {
    
    var user: User?
    
    var photoSpacing: (horizontal: CGFloat, vertical: CGFloat) {
        return (1, 1)
    }
    
    var numberOfPhotosPerRow = 3
    
    var backgroundColor = UIColor.white
    
    var headerHeight: CGFloat = 240
    
    func getPhotoSize(gridWidth: CGFloat) -> CGFloat {
        let horizontalSpacing = photoSpacing.horizontal
        let itemSize = (gridWidth - horizontalSpacing * CGFloat(numberOfPhotosPerRow - 1)) / CGFloat(numberOfPhotosPerRow)
        
        return itemSize
    }
    
    
}
