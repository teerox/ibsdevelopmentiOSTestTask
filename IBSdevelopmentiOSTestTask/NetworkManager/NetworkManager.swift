//
//  NetworkManager.swift
//  IBSdevelopmentiOSTestTask
//
//  Created by Mac on 02/10/2022.
//

import Foundation
import Combine

enum CustomHTTPMethod: String {
    case get = "GET"
}

protocol ServiceProtocol {
    
    /// - Parameters:
    ///   - url: url for request
    ///   - method: methods for POST, GET, PUT and DELETE
    ///   - parameters: request body as dictionary
    /// - Returns: returns AnyPublisher with the data response
    func makeReques<T: Codable>(url :String,
                                method: CustomHTTPMethod) -> AnyPublisher<T, Error>
}

class NetworkManager: ServiceProtocol {
    
    // Create a shared Instance
    static let _shared = NetworkManager()
    
    // Shared Function
    class func shared() -> NetworkManager {
        return _shared
    }
    
    private let baseUrl = "https://randomuser.me"
    
    func makeReques<T>(url: String,
                       method: CustomHTTPMethod) -> AnyPublisher<T, Error> where T : Decodable, T : Encodable {

        guard var urlComponents = URLComponents(string: baseUrl + url) else {
            fatalError("invalid url")
        }
        
        urlComponents.queryItems = []
       
        /// Create a request
        var request = URLRequest(url:  urlComponents.url!,
                                 cachePolicy: .useProtocolCachePolicy,
                                 timeoutInterval:  10 )
        request.httpMethod = method.rawValue
        
        /// Create a session
        return URLSession
            .shared
            .dataTaskPublisher(for: request)
            //.print()
            .map{ $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .map { $0 }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
