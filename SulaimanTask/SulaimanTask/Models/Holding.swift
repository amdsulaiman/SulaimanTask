//
//  Holding.swift
//  SulaimanTask
//
//  Created by Mohammed Sulaiman on 14/01/25.
//

import Foundation

import Foundation

struct Holding: Decodable {
    let symbol: String
    let quantity: Int
    let ltp: Double
    let avgPrice: Double
    let close: Double
    
    enum CodingKeys: String, CodingKey {
        case symbol
        case quantity
        case ltp
        case avgPrice = "avgPrice"
        case close
    }
}

struct HoldingsResponse: Decodable {
    let data: DataHolder
}

struct DataHolder: Decodable {
    let userHolding: [Holding]
}
struct UserHoldingResponse: Decodable {
    let data: HoldingData
}

struct HoldingData: Decodable {
    let userHolding: [Holding]
}
