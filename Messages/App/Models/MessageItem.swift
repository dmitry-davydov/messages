//
//  MessageItem.swift
//  Messages
//
//  Created by Дима Давыдов on 25.09.2021.
//

import Foundation

struct MessageItem: Codable {
    let user: User
    let message: Message
}
