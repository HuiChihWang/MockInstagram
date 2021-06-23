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
    private static let profileImageFolder = "/profile_images"
    
    static func uploadImage(image: UIImage, completion: @escaping (String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.75) else {
            return
        }
        
        let fileName = UUID().uuidString
        let ref = Storage.storage().reference(withPath: "\(profileImageFolder)/\(fileName)")
        
        ref.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("Fail Upload Image: \(error.localizedDescription)")
                return
            }
        }
        
        ref.downloadURL { url, error in
            guard let imageUrl = url?.absoluteString else {
                return
            }
            completion(imageUrl)
        }
    }
}
