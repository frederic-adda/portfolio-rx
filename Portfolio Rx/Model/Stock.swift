//
//  Stock.swift
//  Portfolio Rx
//
//  Created by Frédéric ADDA on 03/12/2017.
//  Copyright © 2017 Frédéric ADDA. All rights reserved.
//

import Foundation


class Stock: CustomStringConvertible {
    
    // MARK: - Properties
    
    // Stored properties
    let name: String
    let symbol: String
    var currency: String = "USD" // must be variable to deal with change from GBX to GBP
    var market: String
    
    var numberOfShares = 0
    var purchaseSharePrice = 0.0
    var currentSharePrice = 0.0
    var intradayEvolutionValue = 0.0
    var intradayEvolutionPercentage = 0.0
    var purchaseCurrencyRate = 1.0
    var currentCurrencyRate = 1.0
    var purchaseDate: Date?
    /** Last trading date recorded for this stock */
    var lastTradeDate: Date?
    /** Unique identifier for this stock, used to let the notifications (alerts) get a pointer to the stock. */
    var uniqueIdentifier: String! = UUID().uuidString
    
    // Computed properties
    /** Calculated as: numberOfShares * purchaseSharePrice */
    var costInLocalCurrency: Double { return Double(numberOfShares) * purchaseSharePrice}
    /** Calculated as: currentSharePrice * numberOfShares */
    var valueInLocalCurrency: Double { return Double(numberOfShares) * currentSharePrice}
    
    /** Purchase cost in portfolio currency (EUR) = cost in local currency (USD) / purchase currency rate (EURUSD=X)
     Calculated as: costInLocalCurrency / purchaseCurrencyRate.
     NB: currency rates must be expressed as :  1 portfolio currency for n local currency (e.g. EUR/USD = n)
     */
    var costInPortfolioCurrency: Double {
        if purchaseCurrencyRate == 0.0 {
            return costInLocalCurrency
        }
        
        if currency == "GBX" { // Special case for GBX (0,01 GBP)
            return (costInLocalCurrency / purchaseCurrencyRate) / 100.0
        } else {
            return costInLocalCurrency / purchaseCurrencyRate
        }
    }
    
    /** Value in portfolio currency (EUR) = value in local currency (USD) / current currency rate (EURUSD=X).
     Calculated as: valueInLocalCurrency / currentCurrencyRate
     NB: currency rates must be expressed as :  1 portfolio currency for n local currency (e.g. EUR/USD = n)
     */
    var valueInPortfolioCurrency: Double {
        if currentCurrencyRate == 0.0 {
            return valueInLocalCurrency
        }
        
        if currency == "GBX" { // Special case for GBX (0,01 GBP)
            return (valueInLocalCurrency / currentCurrencyRate) / 100.0
        } else {
            return valueInLocalCurrency / currentCurrencyRate
        }
    }
    
    /** valueInPortfolioCurrency - costInPortfolioCurrency */
    var gainOrLossValue: Double { return valueInPortfolioCurrency - costInPortfolioCurrency }
    /** (valueInPortfolioCurrency - costInPortfolioCurrency) / costInPortfolioCurrency */
    var gainOrLossPercentage: Double {
        if costInPortfolioCurrency == 0.0 {
            return 0.0
        }
        
        return (valueInPortfolioCurrency - costInPortfolioCurrency) / costInPortfolioCurrency
    }
    
    // Printable protocol
    var description: String {
        return "\(symbol) : \(uniqueIdentifier)"
    }
    
    
    
    // MARK: - Initializers
    
    // Designated Initializer
    init(symbol: String, name: String, market: String, currency: String) {
        self.symbol = symbol
        self.name = name
        self.market = market
        self.currency = currency
    }
    
}
