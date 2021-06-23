//
//  ImageUploader.swift
//  MockInstagram
//
//  Created by Hui Chih Wang on 2021/6/23.
//

import Foundation
import UIKit
import FirebaseStorage

class ImageUploader {
    private static let profileImageFolder = "profile_images/"
    
    static func uploadImage(image: UIImage, completion: @escaping (URL?, Error?) -> Void) {
        
        guard let imageData = image.jpegData(compressionQuality: 0.75) else {
            return
        }
        
        let fileName = UUID().uuidString
        
        let storageRef = Storage.storage().reference()
        
        let ref = storageRef.child("\(profileImageFolder)\(fileName)")
        
        ref.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("uploadI image image data fail: \(error.localizedDescription)")
            }
            
            ref.downloadURL(completion: completion)
        }
        
        
    }
}

