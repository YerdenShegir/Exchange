//
//  ChoosenCurrencies.swift
//  Exchange
//
//  Created by Ерден on 05.10.17.
//  Copyright © 2017 Ерден. All rights reserved.
//

import UIKit
import CoreData
import SnapKit

class ChoosenCurrenciesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let cellId = "cellId"
    var exchange = [ExchangeRates]()
    var choosen = [ChoosenCurrencies]()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
        tableView.register(ChoosenCurrenciesCell.self, forCellReuseIdentifier: cellId)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        tableView.separatorStyle = .none
        
        let fetchRequest: NSFetchRequest<ExchangeRates> = ExchangeRates.fetchRequest()
        do {
            let exchange = try PersistenceService.context.fetch(fetchRequest)
            self.exchange = exchange
        }
        catch let error {
            print(error)
        }
        
        let fetchChoosenRequest: NSFetchRequest<ChoosenCurrencies> = ChoosenCurrencies.fetchRequest()
        do {
            let choosen = try PersistenceService.context.fetch(fetchChoosenRequest)
            self.choosen = choosen
        }
        catch let error {
            print(error)
        }
        
    }
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.dataSource = self
        tv.delegate = self
        return tv
    }()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exchange.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ChoosenCurrenciesCell
        var isFavorite = false
        cell.label.text = exchange[indexPath.row].currency
        cell.selectionStyle = .none

        for i in choosen {
            if let currency = i.currencies {
            if exchange[indexPath.row].currency! == currency {
                isFavorite = true
            }
            }
            
        }
        

        cell.button.setImage(isFavorite ? #imageLiteral(resourceName: "like-filled") : #imageLiteral(resourceName: "heart"), for: .normal)
        cell.button.tag = indexPath.row
        cell.button.addTarget(self, action: #selector(addToFavorites), for: .touchUpInside)
        return cell
    }
    
    @objc func addToFavorites(sender: UIButton) {
        let index = sender.tag
        var currencies = [String]()
        var ratio = [Float]()
        for index in 0..<choosen.count {
            if let currency = choosen[index].currencies {
                currencies.append(currency)
            }
                ratio.append(choosen[index].ratio)
            
            
        }
        
        var isAdded = false
        var deleteIndex = -1
        for i in 0..<currencies.count {
            if currencies[i] == exchange[index].currency! {
                isAdded = true
                deleteIndex = i
            }

        }
        
        if isAdded {
            currencies.remove(at: deleteIndex)
            ratio.remove(at: deleteIndex)
            let context = PersistenceService.context
            
            let fetchRequest: NSFetchRequest<ChoosenCurrencies> = ChoosenCurrencies.fetchRequest()
            do {
                let choosen = try PersistenceService.context.fetch(fetchRequest)
                for row in choosen {
                    context.delete(row)
                }
                try(context.save())
                
            }
            catch let error {
                print(error)
            }
            
            for i in 0..<currencies.count {
                let choosen = ChoosenCurrencies(context: context)
                choosen.currencies = currencies[i]
                choosen.ratio = ratio[i]
                PersistenceService.saveContext()
            }
            
        }
        else {
            
            currencies.append(exchange[index].currency!)
            ratio.append(exchange[index].ratio)
            
            let context = PersistenceService.context
            
            let fetchRequest: NSFetchRequest<ChoosenCurrencies> = ChoosenCurrencies.fetchRequest()
            do {
                let choosen = try PersistenceService.context.fetch(fetchRequest)
                for row in choosen {
                    context.delete(row)
                }
                try(context.save())
                
            }
            catch let error {
                print(error)
            }

            for i in 0..<currencies.count {
                let choosen = ChoosenCurrencies(context: context)
                choosen.currencies = currencies[i]
                choosen.ratio = ratio[i]
                PersistenceService.saveContext()
            }
            

        }
        viewDidLoad()
        tableView.reloadData()
    }

   
}

