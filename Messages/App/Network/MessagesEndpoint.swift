//
//  MessagesEndpoint.swift
//  Messages
//
//  Created by Дима Давыдов on 25.09.2021.
//

import Foundation

enum MessagesEndpoint: NetworkEndpoint {
    case messagesList
    
    var path: String {
        switch self {
        case .messagesList: return "api.json"
        }
    }
}
