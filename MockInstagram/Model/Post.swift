//
//  Post.swift
//  MockInstagram
//
//  Created by Hui Chih Wang on 2021/7/12.
//

import Foundation
import Firebase
struct Post {
    let photoUrl: String
    let description: String
    
    let ownerUid: String
    let date: Date
    
    var likes = [String]()
    
    init?(data: [String: Any]) {
        guard let url = data["photoUrl"] as? String ,
              let description = data["description"] as? String,
              let ownerUid = data["owner"] as? String,
              let date = (data["date"] as? Timestamp)?.dateValue()
        else {
            print("Post Constructor: Construct Fail")
            return nil
        }
        
        self.photoUrl = url
        self.description = description
        self.ownerUid = ownerUid
        self.date = date
        
        self.likes = data["likes"] as? [String] ?? []
    }
}
