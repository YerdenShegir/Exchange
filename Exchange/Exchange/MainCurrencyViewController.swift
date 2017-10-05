//
//  MainCurrencyViewController.swift
//  Exchange
//
//  Created by Ерден on 05.10.17.
//  Copyright © 2017 Ерден. All rights reserved.
//

import UIKit
import CoreData

class MainCurrencyViewController: UITableViewController {
    
    let cellId = "cellId"
    var exchange = [ExchangeRates]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(MainCurrencyCell.self, forCellReuseIdentifier: cellId)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        tableView.separatorStyle = .none
        
        let fetchRequest: NSFetchRequest<ExchangeRates> = ExchangeRates.fetchRequest()
        do {
            let exchange = try PersistenceService.context.fetch(fetchRequest)
            self.exchange = exchange
//            self.exchange.append(usd)
        }
        catch let error {
            print(error)
        }
        
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exchange.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MainCurrencyCell
        cell.label.text = exchange[indexPath.row].currency
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        userDefaults.setСhoosenCurrency(value: exchange[indexPath.row].currency!)
        userDefaults.setChoosenRatio(value: exchange[indexPath.row].ratio)
        
        if let window = UIApplication.shared.keyWindow {
            window.rootViewController = UINavigationController(rootViewController: MainViewController())
        }
    }

}
