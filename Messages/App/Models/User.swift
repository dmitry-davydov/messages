//
//  User.swift
//  Messages
//
//  Created by Дима Давыдов on 25.09.2021.
//

import Foundation

struct User: Codable {
    let nickname: String
    let avatarUrl: String
    
    enum CodingKeys: String, CodingKey {
        case nickname
        case avatarUrl = "avatar_url"
    }
}
