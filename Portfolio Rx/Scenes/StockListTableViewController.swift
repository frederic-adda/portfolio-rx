//
//  StockListTableViewController.swift
//  Portfolio Rx
//
//  Created by Frédéric ADDA on 03/12/2017.
//  Copyright © 2017 Frédéric ADDA. All rights reserved.
//

import UIKit

class StockListTableViewController: UITableViewController {

    // MARK: - Properties
    var stocks = [Stock]()

    
    
    // MARK: - View controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stocks = StockStore.shared.allStocks
    }
    
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StockListCell", for: indexPath)

        let stock = stocks[indexPath.row]
        cell.textLabel?.text = stock.symbol
        
        return cell
    }
    
    
    // MARK: - Navigation
    enum SegueIdentifier: String {
        case showDetail
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier,
        let segueIdentifier = SegueIdentifier(rawValue: identifier)
            else { return }
        
        switch segueIdentifier {
            
        case .showDetail:
            guard let indexPath = tableView.indexPathForSelectedRow,
            let stockDetailVC = segue.destination as? StockDetailViewController
                else { return }
            
            let stock = stocks[indexPath.row]
            let stockDetailViewModel = StockDetailViewModel(stock: stock)
            
            stockDetailVC.viewModel = stockDetailViewModel
        }
    }
}
