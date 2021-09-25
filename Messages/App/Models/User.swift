//
//  User.swift
//  Messages
//
//  Created by Дима Давыдов on 25.09.2021.
//

import Foundation

@objc class User: NSObject, Codable {
    @objc let nickname: String
    @objc let avatarUrl: String
    
    enum CodingKeys: String, CodingKey {
        case nickname
        case avatarUrl = "avatar_url"
    }
}
