//
//  HoldingTests.swift
//  SulaimanTaskTests
//
//  Created by Mohammed Sulaiman on 16/01/25.
//


import XCTest
@testable import SulaimanTask

class HoldingTests: XCTestCase {
    
    func testHoldingModelInitialization() {
        let holding = Holding(symbol: "AAPL", quantity: 10, ltp: 150, avgPrice: 140, close: 145)
        
        XCTAssertEqual(holding.symbol, "AAPL")
        XCTAssertEqual(holding.quantity, 10)
        XCTAssertEqual(holding.ltp, 150)
        XCTAssertEqual(holding.avgPrice, 140)
        XCTAssertEqual(holding.close, 145)
    }
    
    func testProfitLossCalculation() {
        let holding = Holding(symbol: "AAPL", quantity: 10, ltp: 150, avgPrice: 140, close: 145)
        
        let profitLoss = (holding.ltp - holding.avgPrice) * Double(holding.quantity)
        XCTAssertEqual(profitLoss, 100.0, "Profit/Loss calculation is incorrect.")
    }
}
