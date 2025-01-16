//
//  MockNetworkManager.swift
//  SulaimanTask
//
//  Created by Mohammed Sulaiman on 16/01/25.
//

import Foundation


protocol NetworkProtocol {
    func fetchHoldings(completion: @escaping (Result<[Holding], Error>) -> Void)
}

class MockNetworkManager: NetworkProtocol {
    var mockData: UserHoldingResponse?
    var mockError: Error?
    
    func fetchHoldings(completion: @escaping (Result<[Holding], Error>) -> Void) {
        if let error = mockError {
            completion(.failure(error))
        } else if let data = mockData {
            completion(.success(data.data.userHolding))
        }
    }
}
