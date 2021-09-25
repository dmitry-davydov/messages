//
//  Message.swift
//  Messages
//
//  Created by Дима Давыдов on 25.09.2021.
//

import Foundation

struct Message: Codable {
    
    let text: String
    let receivedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case text
        case receivedAt = "receiving_date"
    }
}
