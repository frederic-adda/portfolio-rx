//
//  StockDetailViewController.swift
//  Portfolio Rx
//
//  Created by Frédéric ADDA on 03/12/2017.
//  Copyright © 2017 Frédéric ADDA. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources



class StockDetailViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel: StockDetailViewModel!
    
    private var dataSource: RxTableViewSectionedReloadDataSource<Section>?
    private var bag = DisposeBag()
    
    @IBOutlet private weak var tableView: UITableView!
    
    
    
    // MARK: - View controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.stock.symbol
        
        // Build datasource
        setupDataSource()
        
        // Bind the sections to the tableView
        bindSections()
    }
    
    
    // MARK: RxDataSources
    private func setupDataSource() {
        dataSource = RxTableViewSectionedReloadDataSource<Section>(configureCell: { (datasource, tableView, indexPath, item) -> UITableViewCell in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "StockDetailCell", for: indexPath)
            
            // Default cell text formatting
            cell.textLabel?.textColor = .black
            cell.detailTextLabel?.textColor = .darkGray
            
            // Disable cell selection
            cell.selectionStyle = .none
            
            let stock = self.viewModel.stock
            
            switch item {
                
            case .numberOfShares:
                cell.textLabel?.text = NSLocalizedString("Detail VC:number of shares", comment: "Number of shares")
                cell.detailTextLabel?.text = String(stock.numberOfShares)
                
            case .datePurchase:
                // NB: should not appear if purchaseDate is nil
                cell.textLabel?.text = NSLocalizedString("Stock Purchase VC:purchase date", comment: "Purchase date")
                if let purchaseDate = stock.purchaseDate {
                    cell.detailTextLabel?.text = Formatters.shared.shortDateFormatter.string(from: purchaseDate)
                } else {
                    cell.detailTextLabel?.text = "?"
                }
                
            case .pricePurchase:
                cell.textLabel?.text = NSLocalizedString("Detail VC:purchase share price", comment: "Purchase share price")
                cell.detailTextLabel?.text = Formatters.shared.sharePriceFormatter.string(from: stock.purchaseSharePrice as NSNumber)
                
            case .priceCurrent:
                cell.textLabel?.text = NSLocalizedString("Detail VC:current share price", comment: "Current share price")
                cell.detailTextLabel?.text = Formatters.shared.sharePriceFormatter.string(from: stock.currentSharePrice as NSNumber)
                
            case .currencyRatePurchase:
                cell.textLabel?.text = NSLocalizedString("Detail VC:purchase currency rate", comment: "Purchase currency rate")
                cell.detailTextLabel?.text = Formatters.shared.currencyRateFormatter.string(from: stock.purchaseCurrencyRate as NSNumber)
                
            case .currencyRateCurrent:
                cell.textLabel?.text = NSLocalizedString("Detail VC:current currency rate", comment: "Current currency rate")
                cell.detailTextLabel?.text = Formatters.shared.currencyRateFormatter.string(from: stock.currentCurrencyRate as NSNumber)
                
            case .valuationPurchase:
                
                cell.textLabel?.text = NSLocalizedString("Detail VC:cost of stock", comment: "Cost of stock")
                cell.detailTextLabel?.text = Formatters.shared.sharePriceFormatter.string(from: stock.costInPortfolioCurrency as NSNumber)
                
            case .valuationCurrent:
                cell.textLabel?.text = NSLocalizedString("Detail VC:value of stock", comment: "Value of stock")
                cell.detailTextLabel?.text = Formatters.shared.sharePriceFormatter.string(from: stock.valueInPortfolioCurrency as NSNumber)
                
                
            case .gainOrLossValue:
                cell.textLabel?.text = NSLocalizedString("Detail VC:gain or loss value", comment: "Gain or loss value")
                if let formattedGainOrLossValueString = Formatters.shared.sharePriceFormatter.string(from: fabs(stock.gainOrLossValue) as NSNumber) {
                    if stock.gainOrLossValue > 0 {
                        cell.detailTextLabel?.text = "\(GlobalSettings.shared.portfolioCurrency)  + \(formattedGainOrLossValueString)"
                        cell.detailTextLabel?.textColor = .green
                    } else {
                        cell.detailTextLabel?.text = "\(GlobalSettings.shared.portfolioCurrency)  - \(formattedGainOrLossValueString)"
                        cell.detailTextLabel?.textColor = .red
                    }
                }
                
            case .gainOrLossPercentage:
                cell.textLabel?.text = NSLocalizedString("Detail VC:gain or loss percentage", comment: "Gain or loss percentage")
                if let formattedGainOrLossPercentageString = Formatters.shared.percentageFormatter.string(from: fabs(stock.gainOrLossPercentage) as NSNumber) {
                    if stock.gainOrLossPercentage > 0 {
                        cell.detailTextLabel?.text = "+ \(formattedGainOrLossPercentageString)"
                        cell.detailTextLabel?.textColor = .green
                    } else {
                        cell.detailTextLabel?.text = "- \(formattedGainOrLossPercentageString)"
                        cell.detailTextLabel?.textColor = .red
                    }
                }
            }
            
            return cell
        },
        titleForHeaderInSection: { datasource, index in
            
            let stock = self.viewModel.stock

            var sectionLocalizedString = String()
            
            var currency = stock.currency
            // Special case for GBX (0,01 GBP)
            if currency == "GBX" { currency = "GBP" }
            
            let currentSection = datasource.sectionModels[index]
            switch currentSection.type {
            case .general:
                return "\(stock.name) - \(stock.market)"
            case .price:
                sectionLocalizedString = NSLocalizedString("Detail VC:section share price", comment: "Share price")
                return "\(sectionLocalizedString) (\(stock.currency))"
            case .currencyRate:
                sectionLocalizedString = NSLocalizedString("Detail VC:section currency rate", comment: "Currency rate")
                return "\(sectionLocalizedString) (\(GlobalSettings.shared.portfolioCurrency)/\(currency))"
            case .valuation:
                sectionLocalizedString = NSLocalizedString("Detail VC:section stock valuation", comment: "Stock valuation")
                return "\(sectionLocalizedString) (\(GlobalSettings.shared.portfolioCurrency))"
            case .gainOrLoss:
                return NSLocalizedString("Detail VC:section gain or loss", comment: "Gain or loss")
            }
        })
        
    }
    
    
    
    private func bindSections() {
        
        guard let dataSource = self.dataSource else { return }
        
        viewModel.sections
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
    
    }
}

