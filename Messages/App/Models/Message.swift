//
//  Message.swift
//  Messages
//
//  Created by Дима Давыдов on 25.09.2021.
//

import Foundation

@objc class Message: NSObject, Codable {
    
    @objc let text: String
    @objc let receivedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case text
        case receivedAt = "receiving_date"
    }
}
