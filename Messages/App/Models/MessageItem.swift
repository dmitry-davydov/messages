//
//  MessageItem.swift
//  Messages
//
//  Created by Дима Давыдов on 25.09.2021.
//

import Foundation

@objc class MessageItem: NSObject, Codable {
    @objc let user: User
    @objc let message: Message
}
