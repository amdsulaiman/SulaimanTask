//
//  HoldingsViewModelTests.swift
//  SulaimanTaskTests
//
//  Created by Mohammed Sulaiman on 16/01/25.
//

// HoldingsViewModelTests.swift
import XCTest
@testable import SulaimanTask

class HoldingsViewModelTests: XCTestCase {

    var viewModel: HoldingsViewModel!
    var mockNetworkManager: MockNetworkManager!
    
    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        viewModel = HoldingsViewModel(networkManager: mockNetworkManager)
    }
    
    override func tearDown() {
        viewModel = nil
        mockNetworkManager = nil
        super.tearDown()
    }
    
    // MARK: - Test Cases
    
    func testLoadHoldingsSuccess() {
        // Given
        let mockHoldings = [
            Holding(symbol: "MAHABANK", quantity: 990, ltp: 38.05, avgPrice: 35, close: 40),
            Holding(symbol: "ICICI", quantity: 100, ltp: 118.25, avgPrice: 110, close: 105)
        ]
        
        let mockResponse = UserHoldingResponse(data: HoldingData(userHolding: mockHoldings))
        mockNetworkManager.mockData = mockResponse
        
        let expectation = self.expectation(description: "Data should be loaded")
        
        viewModel.onDataUpdated = {
            XCTAssertEqual(self.viewModel.numberOfHoldings(), 2)
            XCTAssertEqual(self.viewModel.holding(at: 0).symbol, "MAHABANK")
            expectation.fulfill()
        }
        
        // When
        viewModel.loadHoldings()
        
        // Then
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testLoadHoldingsFailure() {
        // Given
        let expectedError = NetworkError.noData
        mockNetworkManager.mockError = expectedError
        
        let expectation = self.expectation(description: "Error should be triggered")
        
        viewModel.onErrorOccurred = { (error: Error) in
            XCTAssertEqual(error as? NetworkError, expectedError)
            expectation.fulfill()
        }
        
        // When
        viewModel.loadHoldings()
        
        // Then
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testLoadHoldingsEmptyData() {
        // Given
        let emptyHoldings: [Holding] = []
        let mockResponse = UserHoldingResponse(data: HoldingData(userHolding: emptyHoldings))
        mockNetworkManager.mockData = mockResponse
        
        let expectation = self.expectation(description: "Empty data should result in no holdings")
        
        viewModel.onDataUpdated = {
            XCTAssertEqual(self.viewModel.numberOfHoldings(), 0)
            expectation.fulfill()
        }
        
        // When
        viewModel.loadHoldings()
        
        // Then
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testLoadHoldingsDataParsing() {
        // Given
        let mockHoldings = [
            Holding(symbol: "MAHABANK", quantity: 990, ltp: 38.05, avgPrice: 35, close: 40)
        ]
        let mockResponse = UserHoldingResponse(data: HoldingData(userHolding: mockHoldings))
        mockNetworkManager.mockData = mockResponse
        
        let expectation = self.expectation(description: "Data should be parsed correctly")
        
        viewModel.onDataUpdated = {
            let firstHolding = self.viewModel.holding(at: 0)
            XCTAssertEqual(firstHolding.symbol, "MAHABANK")
            XCTAssertEqual(firstHolding.quantity, 990)
            XCTAssertEqual(firstHolding.ltp, 38.05)
            expectation.fulfill()
        }
        
        // When
        viewModel.loadHoldings()
        
        // Then
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testLoadHoldingsInvalidURL() {
        // Given
        mockNetworkManager.mockError = NetworkError.invalidURL
        
        let expectation = self.expectation(description: "Invalid URL should trigger error")
        
        viewModel.onErrorOccurred = { (error: Error) in
            XCTAssertEqual(error as? NetworkError, NetworkError.invalidURL)
            expectation.fulfill()
        }
        
        // When
        viewModel.loadHoldings()
        
        // Then
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testLoadHoldingsNoData() {
        // Given
        mockNetworkManager.mockError = NetworkError.noData
        
        let expectation = self.expectation(description: "No data error should be triggered")
        
        viewModel.onErrorOccurred = { (error: Error) in
            XCTAssertEqual(error as? NetworkError, NetworkError.noData)
            expectation.fulfill()
        }
        
        // When
        viewModel.loadHoldings()
        
        // Then
        waitForExpectations(timeout: 1, handler: nil)
    }
}
