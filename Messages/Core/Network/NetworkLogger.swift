//
//  NetworkLogger.swift
//  Messages
//
//  Created by Дима Давыдов on 25.09.2021.
//

import Alamofire

final class NetworkLogger: EventMonitor {
    let queue = DispatchQueue.main
    
    func requestDidResume(_ request: Request) {
        debugPrint("Resuming: \(request.request?.debugDescription ?? request.description)")
    }
    
    // Event called whenever a DataRequest has parsed a response.
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        debugPrint("Finished: \(response)")
    }
}
