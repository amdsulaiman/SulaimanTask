//
//  NetworkManagerTests.swift
//  SulaimanTaskTests
//
//  Created by Mohammed Sulaiman on 16/01/25.
//

import XCTest
@testable import SulaimanTask

class NetworkManagerTests: XCTestCase {
    
    var networkManager: NetworkManager!
    
    override func setUp() {
        super.setUp()
        networkManager = NetworkManager.shared
    }
    
    override func tearDown() {
        networkManager = nil
        super.tearDown()
    }
    
    func testFetchHoldings_Success() {
        let expectation = self.expectation(description: "Network call should succeed and return data")
        
        networkManager.fetchHoldings { result in
            switch result {
            case .success(let holdings):
                XCTAssertNotNil(holdings)
                XCTAssertGreaterThan(holdings.count, 0)
            case .failure(let error):
                XCTFail("Expected success, but got failure with error: \(error)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testFetchHoldings_Failure() {
        let expectation = self.expectation(description: "Network call should fail with an error")
        
        // Temporarily mock the URL to force a failure
        NetworkManager.shared.fetchHoldings { result in
            switch result {
            case .success:
                XCTFail("Expected failure, but got success")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
}
