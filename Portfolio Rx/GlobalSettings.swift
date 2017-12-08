//
//  GlobalSettings.swift
//  ZEN Portfolio
//
//  Created by Frédéric ADDA on 16/06/2014.
//  Copyright (c) 2014 Frédéric ADDA. All rights reserved.
//

import Foundation

// MARK: - Constant keys
// Keys for UserDefaults dictionary
struct Defaults {
    static let currencyPrefKey              = "ZENPortfolioCurrencyPrefKey"
}



class GlobalSettings {
    
    // MARK: - Singleton
    static let shared = GlobalSettings()
    
    
    // MARK: - Properties in UserDefaults
    
    ///  Portfolio Currency
    var portfolioCurrency: String {
        get {
            // Point to UserDefaults to retrieve the portfolio currency
            return UserDefaults.standard.string(forKey: Defaults.currencyPrefKey)!
        }
        set {
            // Stock the portfolio currency as UserDefaults
            UserDefaults.standard.set(newValue, forKey: Defaults.currencyPrefKey)
            print("Portfolio currency \(newValue) stored as UserDefaults")
        }
    }
}



