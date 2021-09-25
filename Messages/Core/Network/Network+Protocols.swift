//
//  Network+Protocols.swift
//  Messages
//
//  Created by Дима Давыдов on 25.09.2021.
//

import Alamofire

protocol NetworkEndpoint: URLRequestConvertible {
    var server: Server { get }
    var path: String { get }
    var headers: HTTPHeaders { get }
    var method: HTTPMethod { get }
    var params: Parameters { get }
    var encoding: ParameterEncoding { get }
    var encodingDestination: URLEncoding.Destination { get }
}

extension NetworkEndpoint {
    var method: HTTPMethod {
        return .get
    }
    
    var headers: HTTPHeaders {
        return []
    }
    
    var server: Server {
        return Server.dev
    }
    
    var params: Parameters {
        return [:]
    }
    
    var encodingDestination: URLEncoding.Destination {
        return .queryString
    }
    
    var encoding: ParameterEncoding {
        return URLEncoding.default
    }
}

extension NetworkEndpoint {
    func asURLRequest() throws -> URLRequest {
        return try URLRequest(with: self)
    }
}

extension URLComponents {
    init(with endpoint: NetworkEndpoint) {
        let url = endpoint.server.baseURL.appendingPathComponent(endpoint.path)
        self.init(url: url, resolvingAgainstBaseURL: false)!
    }
}

extension URLRequest {
    init(with endpoint: NetworkEndpoint) throws {
        let urlCompsonents = URLComponents(with: endpoint)
        try self.init(url: urlCompsonents, method: endpoint.method, headers: endpoint.headers)
        
        self = try endpoint.encoding.encode(self, with: endpoint.params)
    }
}
