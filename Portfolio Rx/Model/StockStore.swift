//
//  StockStore.swift
//  Portfolio Rx
//
//  Created by Frédéric ADDA on 03/12/2017.
//  Copyright © 2017 Frédéric ADDA. All rights reserved.
//

import Foundation

class StockStore: NSObject {
    // Need to reference the old Obj-C class name to retrieve the archive
    
    
    // MARK: - Singleton
    static let shared = StockStore()
    
    
    // MARK: - Properties
    // Stored properties
    var allStocks = [Stock]()

}
