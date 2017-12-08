//
//  StockDetailViewModel.swift
//  Portfolio Rx
//
//  Created by Frédéric ADDA on 03/12/2017.
//  Copyright © 2017 Frédéric ADDA. All rights reserved.
//

import UIKit

class StockDetailViewModel {
    
    // MARK: - Initializer
    init(stock: Stock) {
        
        self.stock = stock
        
        var currency = stock.currency
        // Special case for GBX (0,01 GBP)
        if currency == "GBX" { currency = "GBP" }
        
        self.sections = [
            Section(type: .general, items: [.numberOfShares, .datePurchase]),
            Section(type: .price, items: [.pricePurchase, .priceCurrent]),
            Section(type: .valuation, items: [.valuationPurchase, .valuationCurrent]),
            Section(type: .gainOrLoss, items: [.gainOrLossValue, .gainOrLossPercentage])
        ]
        
        if currency != GlobalSettings.shared.portfolioCurrency {
            
            let currencyRateSection = Section(type: .currencyRate, items: [.currencyRatePurchase, .currencyRateCurrent])
            sections.insert(currencyRateSection, at: 3)
        }
    }
    
    // MARK: - Input
    var stock: Stock
    
    
    // MARK: - Output
    private(set) var sections: [Section]
    
    struct Section {
        var type: SectionType
        var items: [Item]
    }
    
    enum SectionType {
        case general
        case price
        case currencyRate
        case valuation
        case gainOrLoss
    }
    
    enum Item {
        case numberOfShares
        case datePurchase
        case pricePurchase
        case priceCurrent
        case currencyRatePurchase
        case currencyRateCurrent
        case valuationPurchase
        case valuationCurrent
        case gainOrLossValue
        case gainOrLossPercentage
    }
    
}
