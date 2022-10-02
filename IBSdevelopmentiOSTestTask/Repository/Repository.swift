//
//  Repository.swift
//  IBSdevelopmentiOSTestTask
//
//  Created by Mac on 02/10/2022.
//

import Foundation
import Combine

class Repository {
    
    private let networkManger: ServiceProtocol!
    private var cancellableSet: Set<AnyCancellable> = []
    
    /// Initialze Network Manager and cache manager here
    /// - Parameters: For Testing Purpose mocked `networkManger`
    /// can be injected into this viewModel
    ///   - networkManger: Fetch result from Api
    init(with networkManger: ServiceProtocol = NetworkManager.shared()) {
        self.networkManger = networkManger
    }
    
    func fetchAllData(counts: [Int] = [1,2,3]) -> AnyPublisher<[Result], Error> {
        let result: AnyPublisher<ResponseModel, Error> = networkManger.makeReques(url: "/api",method: .get)
        
       return counts.reduce(Optional<AnyPublisher<[Result], Error>>.none) { state, id in
            guard let state = state
            else {
                return result
                    .map { $0.results }
                .eraseToAnyPublisher()
            }
            return state
                .combineLatest(result)
                .map { $0.0 + $0.1.results}
                .eraseToAnyPublisher()
        } ?? Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
}