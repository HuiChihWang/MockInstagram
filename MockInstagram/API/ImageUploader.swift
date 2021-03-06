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
    static func uploadImage(image: UIImage, destination: String, completion: @escaping (URL?, Error?) -> Void) {
        
        guard let imageData = image.jpegData(compressionQuality: 0.75) else {
            return
        }
        
        let fileName = UUID().uuidString
        
        let storageRef = Storage.storage().reference()
        
        let ref = storageRef.child("\(destination)/\(fileName)")
        
        ref.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("uploadI image image data fail: \(error.localizedDescription)")
                completion(nil, error)
            }
            
            ref.downloadURL(completion: completion)
        }
        
        
    }
}

