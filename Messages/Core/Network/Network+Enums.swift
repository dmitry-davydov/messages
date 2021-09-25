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
        case notFound
        case conflict
        case gone
        case badRequest
        case noInternetConnection
    }
}
