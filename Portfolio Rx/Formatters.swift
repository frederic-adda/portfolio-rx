//
//  Formatters.swift
//
//  Created by Frédéric ADDA on 02/04/2017.
//  Copyright © 2017 Frédéric ADDA. All rights reserved.
//

import Foundation


class Formatters: NSObject {
    
    override private init() { }
    
    // MARK: - Properties
    
    // MARK: Singleton
    static let shared = Formatters()
    
    
    // MARK: - Number formatters
    
    /// Integer formatter
    lazy var integerFormatter: NumberFormatter = {
       let formatter = NumberFormatter()
        formatter.numberStyle = .none
        return formatter
    }()
    
    /// Formatter for number of shares (no digit)
    lazy var numberOfSharesFormatter: NumberFormatter = {
        let intFormatter = NumberFormatter()
        intFormatter.numberStyle = .decimal
        intFormatter.maximumFractionDigits = 0
        intFormatter.locale = Locale.current
        return intFormatter
    }()
    
    /// Decimal formatter for Share price (2 fraction digits)
    lazy var sharePriceFormatter: NumberFormatter = {
        var decimalFormatter = NumberFormatter()
        decimalFormatter.numberStyle = .decimal
        decimalFormatter.minimumFractionDigits = 2
        decimalFormatter.maximumFractionDigits = 2
        decimalFormatter.locale = Locale.current
        return decimalFormatter
    }()
    
    /// Decimal formatter for Currency rate (4 fraction digits)
    lazy var currencyRateFormatter: NumberFormatter = {
        var rateFormatter = NumberFormatter()
        rateFormatter.numberStyle = .decimal
        rateFormatter.minimumFractionDigits = 4
        rateFormatter.maximumFractionDigits = 4
        rateFormatter.locale = Locale.current
        return rateFormatter
    }()
    
    /// Percentage formatter for Gain or loss % (2 fraction digits)
    lazy var percentageFormatter: NumberFormatter = {
        var percentFormatter = NumberFormatter()
        percentFormatter.numberStyle = .percent
        percentFormatter.minimumFractionDigits = 2
        percentFormatter.maximumFractionDigits = 2
        percentFormatter.locale = Locale.current
        return percentFormatter
    }()
    
    
    // MARK: - Date formatters
    
    /*
    /// Server date formatter
    lazy var serverDateFormatter: DateFormatter = {
        let gmtFormatter = DateFormatter()
        gmtFormatter.locale = Locale(identifier:"en_US_POSIX")
        gmtFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'" // example: "2016-03-08T15:20:43Z"
        gmtFormatter.timeZone = TimeZone(abbreviation:"GMT")
        return gmtFormatter
    }()
    */
    
    /*
    /// Server local date formatter
    lazy var serverDateFormatter2: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier:"en_US_POSIX")
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mma" // example: "3/8/2016 10:02am"
        return dateFormatter
    }()
    */
    
    /// Short date formatter
    lazy var shortDateFormatter: DateFormatter = {
        var formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter
    }()
    
    /// Alpha Vantage server date formatter
    lazy var alphaVantageServerDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // example: "2017-11-03 16:00:00"
        dateFormatter.timeZone = TimeZone(abbreviation: "EST")
        return dateFormatter
    }()
    
    /// Audioplayer time formatter 'mm:ss'
    lazy var audioTimeFormatter: DateComponentsFormatter = {
            let dateComponentsFormatter = DateComponentsFormatter()
            dateComponentsFormatter.zeroFormattingBehavior = .pad
            dateComponentsFormatter.allowedUnits = [.minute, .second]
            return dateComponentsFormatter
        }()
}
