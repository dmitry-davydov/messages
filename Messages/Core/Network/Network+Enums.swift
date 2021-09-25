//
//  Network+Enums.swift
//  Messages
//
//  Created by Дима Давыдов on 25.09.2021.
//

import Foundation

enum Network {
    enum Error: LocalizedError, Equatable {
        case unknown
        case responseSerialization
        case noInternetConnection
        case timeout
        
        var asWrappedError: NetworkErrorWrapper {
            switch self {
            case .unknown: return .unknown
            case .responseSerialization: return .responseSerialization
            case .timeout: return .timeout
            case .noInternetConnection: return .noInternetConnection
            }
        }
    }
}

@objc enum NetworkErrorWrapper: NSInteger {
    case unknown
    case responseSerialization
    case noInternetConnection
    case timeout
}

