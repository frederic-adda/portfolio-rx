//
//  Mock.swift
//  ZEN Portfolio
//
//  Created by Frédéric ADDA on 31/10/2017.
//  Copyright © 2017 Frédéric ADDA. All rights reserved.
//

import Foundation

struct Mock {
    
    
    /** Defines test data directly in the model. */
    static func createTestData(fromPlist fileName: String, currencyCode: String? = nil) -> [Stock] {
        
        // Set portfolio currency
        let userCurrencyCode = "EUR"
        
        // Set the portfolio currency
        GlobalSettings.shared.portfolioCurrency = userCurrencyCode
        
        
        // Number formatter to parse Plist file (locale = US because decimal separator is '.')
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier:"en_US")
        
        // Date formatter to parse Plist file (locale = FR because dates are formatted DD/MM/YYYY)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "fr_FR")
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        // Get sample data from the plist file
        guard let path = Bundle.main.path(forResource: fileName, ofType: "plist"),
            let dataArray = NSDictionary(contentsOfFile: path)
            else {
                return []
        }
            
        // Create current stocks
        var newStocks = [Stock]()
        let stocks = dataArray["stocks"] as! [NSDictionary]
        
        for stock in stocks {
            let symbol = stock["symbol"] as! String
            let name = stock["name"] as! String
            let market = stock["market"] as! String
            let currency = stock["currency"] as! String
            
            let newStock = Stock(symbol: symbol, name: name, market: market, currency: currency)
            newStock.numberOfShares = Int((stock["numberOfShares"] as! String))!
            
            //            newStock.purchaseSharePrice = (stock["purchaseSharePrice"] as NSString).doubleValue
            newStock.purchaseSharePrice = numberFormatter.number(from: stock["purchaseSharePrice"] as! String)!.doubleValue
            newStock.currentSharePrice = numberFormatter.number(from: stock["currentSharePrice"] as! String)!.doubleValue
            
            if  userCurrencyCode == currency {
                newStock.purchaseCurrencyRate = 1.0000
                newStock.currentCurrencyRate = 1.0000
            } else {
                let currencyRateCode = "\(userCurrencyCode)\(currency)"
                let purchaseCurrencyRateDict = stock["purchaseCurrencyRate"] as! NSDictionary
                newStock.purchaseCurrencyRate = numberFormatter.number(from: purchaseCurrencyRateDict[currencyRateCode] as! String)!.doubleValue
                
                let currentCurrencyRateDict = stock["currentCurrencyRate"] as! NSDictionary
                newStock.currentCurrencyRate = numberFormatter.number(from: currentCurrencyRateDict[currencyRateCode] as! String)!.doubleValue
            }
            newStock.purchaseDate = dateFormatter.date(from: stock["purchaseDate"] as! String)
            
            // Add the new stock to the array
            newStocks.append(newStock)
        }
        
        return newStocks
    }
    
    
    
}
