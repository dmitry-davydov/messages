//
//  NetworkSessionProvider.swift
//  Messages
//
//  Created by Дима Давыдов on 25.09.2021.
//

import Alamofire

final class NetworkSessionProvider {
    static let shared = NetworkSessionProvider()
    
    private let session: Session
    private let rootQueue = DispatchQueue(label: "ru.davdima.Messages.Network.rootQueue")
    private let logger: NetworkLogger = NetworkLogger()
    
    private init() {
        let configuration = URLSessionConfiguration.af.default
        configuration.allowsCellularAccess = true
        
        self.session = Session(
            configuration: configuration,
            delegate: SessionDelegate(),
            rootQueue: rootQueue,
            startRequestsImmediately: true,
            requestQueue: nil,
            serializationQueue: nil,
            interceptor: nil,
            serverTrustManager: nil,
            redirectHandler: nil,
            cachedResponseHandler: nil,
            eventMonitors: [logger]
        )
    }
    
    func request<T: Decodable>(_ type: T.Type, endpoint: NetworkEndpoint, callbackQueue: DispatchQueue, completion: @escaping (Swift.Result<T, Network.Error>) -> Void) {
        
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss+SSS"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        let dataRequest = session.request(endpoint)
            .validate()
            .responseJSON(completionHandler: { response in
                debugPrint(response)
            })
            .responseDecodable(
                of: type,
                queue: callbackQueue,
                dataPreprocessor: DecodableResponseSerializer<T>.defaultDataPreprocessor,
                decoder: decoder,
                emptyResponseCodes: DecodableResponseSerializer<T>.defaultEmptyResponseCodes,
                emptyRequestMethods: DecodableResponseSerializer<T>.defaultEmptyRequestMethods
            ) { [weak self] response in
                self?.handleResponse(response, completion: completion)
            }
        
        dataRequest.cURLDescription { desc in
            debugPrint(desc)
        }
    }
    
    private func handleResponse<T>(_ dataResponse: DataResponse<T, AFError>, completion: @escaping (Result<T, Network.Error>) -> Void) {
        switch dataResponse.result {
        case .failure(let afError):
            switch afError {
            case .sessionTaskFailed(let urlError as URLError):
                switch urlError.code {
                case .notConnectedToInternet:
                    completion(.failure(.noInternetConnection))
                case .timedOut:
                    completion(.failure(.timeout))
                default:
                    completion(.failure(.unknown))
                }
            case .requestAdaptationFailed(let error):
                debugPrint(error)
            case .responseSerializationFailed:
                completion(.failure(.responseSerialization))
                
            case .responseValidationFailed:
                switch dataResponse.response?.statusCode {
                default:
                    completion(.failure(.unknown))
                }
                
            default:
                completion(.failure(.unknown))
            }
        case .success(let response):
            completion(.success(response))
        }
    }
}
