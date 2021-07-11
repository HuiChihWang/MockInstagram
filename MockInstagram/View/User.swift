//
//  User.swift
//  MockInstagram
//
//  Created by Hui Chih Wang on 2021/7/10.
//

import Foundation

struct User {
    let email: String
    let fullName: String
    let userName: String
    let uid: String
    
    var imageUrl: String?
}

extension User: Codable {
    enum CodingKeys: String, CodingKey {
        case email
        case fullName
        case userName
        case imageUrl
        case uid
    }
}
