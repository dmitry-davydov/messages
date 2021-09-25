//
//  MessagesManager.swift
//  Messages
//
//  Created by Дима Давыдов on 25.09.2021.
//

import Foundation

protocol MessagesManagerProtocol {
    func fetchList(on success: @escaping(_ result: [MessageItem]) -> Void, onError: @escaping(_ error: NetworkErrorWrapper) -> Void)
}

@objc final class MessagesManager: NSObject, MessagesManagerProtocol {
    private let sessionProvider: NetworkSessionProvider = NetworkSessionProvider.shared
    
    @objc func fetchList(on success: @escaping(_ result: [MessageItem]) -> Void, onError: @escaping(_ error: NetworkErrorWrapper) -> Void) {
        sessionProvider.request([MessageItem].self, endpoint: MessagesEndpoint.messagesList, callbackQueue: .main) { result in
            switch result {
            case .success(let messagesItemList):
                success(messagesItemList)
            case .failure(let error):
                onError(error.asWrappedError)
            }
        }
    }
}

