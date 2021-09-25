//
//  Server.swift
//  Messages
//
//  Created by Дима Давыдов on 25.09.2021.
//

import Foundation

enum Server {
    case dev
}

protocol ServerProtocol {
    var baseURL: URL { get }
}

extension Server: ServerProtocol {
    var baseURL: URL {
        switch self {
        case .dev:
            guard let url = URL(string: App.Network.api) else {
                fatalError("Invalid server configuration with baseURL: \(App.Network.api)")
            }
            
            return url
        }
    }
}
