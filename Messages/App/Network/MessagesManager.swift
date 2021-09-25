//
//  MessagesManager.swift
//  Messages
//
//  Created by Дима Давыдов on 25.09.2021.
//

import Foundation

protocol MessagesManagerProtocol {
    func fetchList(completion: @escaping(_ result: Result<[MessageItem], Network.Error>) -> Void)
}

@objc final class MessagesManager: NSObject, MessagesManagerProtocol {
    private let sessionProvider: NetworkSessionProvider = NetworkSessionProvider.shared
    
    func fetchList(completion: @escaping(_ result: Result<[MessageItem], Network.Error>) -> Void) {
        sessionProvider.request([MessageItem].self, endpoint: MessagesEndpoint.messagesList, callbackQueue: .main) { result in
            switch result {
            case .success(let messagesItemList):
                completion(.success(messagesItemList))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

