//
//  HoldingsViewModel.swift
//  SulaimanTask
//
//  Created by Mohammed Sulaiman on 15/01/25.
//

// MARK: - HoldingsViewModel
import Foundation

class HoldingsViewModel {
    var holdings: [Holding] = []
    
    
    // Notify the controller when data is loaded
    var onDataUpdated: (() -> Void)?
    
    
    //Load holdings data from API
    func loadHoldings() {
        guard let url = URL(string: "https://35dee773a9ec441e9f38d5fc249406ce.api.mockbin.io/") else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            // Attempt to decode the data
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(HoldingsResponse.self, from: data)
                self.holdings = decodedResponse.data.userHolding
                
                // Notify the UI that the data has been updated
                DispatchQueue.main.async {
                    self.onDataUpdated?()
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }
        
        task.resume()
    }
    // Number of holdings
    func numberOfHoldings() -> Int {
        return holdings.count
    }
    
    // Get holding at a specific index
    func holding(at index: Int) -> Holding {
        return holdings[index]
    }
    
    func calculateCurrentValue() -> Double {
        return holdings.reduce(into: 0.0) { total, holding in
            total += holding.ltp * Double(holding.quantity)
        }
    }
    
    func calculateTotalInvestment() -> Double {
        return holdings.reduce(into: 0.0) { total, holding in
            total += holding.avgPrice * Double(holding.quantity)
        }
    }
    
    func calculateTotalPNL() -> Double {
        let currentValue = calculateCurrentValue()
        let totalInvestment = calculateTotalInvestment()
        return currentValue - totalInvestment
    }
    
    func calculateTodayPNL() -> Double {
        return holdings.reduce(into: 0.0) { total, holding in
            total += (holding.close - holding.ltp) * Double(holding.quantity)
        }
    }
    
    func updateProfitAndLossForView(bottomSheetView: BottomSheetView) {
        let currentValue = calculateCurrentValue()
        let totalInvestment = calculateTotalInvestment()
        let totalPNL = calculateTotalPNL()
        let todayPNL = calculateTodayPNL()
        
        bottomSheetView.updateProfitAndLoss(profitAndLoss: totalPNL, currentValue: currentValue, totalInvestment: totalInvestment, todayPNL: todayPNL)
    }
}
