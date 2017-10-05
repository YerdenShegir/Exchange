//
//  ViewController.swift
//  Exchange
//
//  Created by Ерден on 03.10.17.
//  Copyright © 2017 Ерден. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var exchange = [ExchangeRates]()
    var choosen = [ChoosenCurrencies]()
    let cellId = "cellId"
    var date = Date()
    

    var exchangeRates = [DownloadRates]() {
        didSet {
            saveData(exchangeRates: exchangeRates)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !userDefaults.isLaunchedBefore() {
            checkForInternet()
            userDefaults.setСhoosenCurrency(value: "USD")
            userDefaults.setChoosenRatio(value: 1.0)
            userDefaults.setIsLaunchedBefore(value: true)
        }
        
        else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let currentDateString = dateFormatter.string(from: Date())
            
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "hh:mm:ss"
            let currentTimeString = timeFormatter.string(from: Date())
            let updateTimeString = "12:00:00"
            
            let stringFormatter = DateFormatter()
            stringFormatter.dateFormat = "yyyy-MM-dd"
            let currentDate = stringFormatter.date(from: currentDateString)
            
            let stringTimeFormatter = DateFormatter()
            stringTimeFormatter.dateFormat = "hh:mm:ss"
            let currentTime = stringTimeFormatter.date(from: currentTimeString)
            let updateTime = stringTimeFormatter.date(from: updateTimeString)
            
            let lastUpdateString = userDefaults.lastUpdateDate()
            let lastUpdateDate = stringFormatter.date(from: lastUpdateString)
            print(currentDate!)
            print(lastUpdateDate!)
            if currentDate! > lastUpdateDate! {
                print("update!")
                checkForInternet()
                userDefaults.setNumberOfUpdates(value: 1)
            }

            else if (currentTime! > updateTime! && userDefaults.numberOfUpdates() < 2) {
                userDefaults.setNumberOfUpdates(value: 2)
                checkForInternet()
            }
        }
        

        
        let fetchRequest: NSFetchRequest<ExchangeRates> = ExchangeRates.fetchRequest()
        do {
            let exchange = try PersistenceService.context.fetch(fetchRequest)
            self.exchange = exchange
            self.tableView.reloadData()
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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(pushToSettingsViewController))
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
        tableView.register(MainCell.self, forCellReuseIdentifier: cellId)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        
    }

 
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if choosen.count > 0 {
            return choosen.count
        }
        return exchange.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MainCell
        if choosen.count == 0 {
        if let currency = exchange[indexPath.row].currency {
        cell.currenciesLabel.text = "\(userDefaults.choosenCurrency())/\(currency)"
        }
        let ratio = exchange[indexPath.row].ratio / userDefaults.choosenRatio()
        cell.ratioLabel.text = String(ratio)
        }
        else {
            if let currency = choosen[indexPath.row].currencies {
                cell.currenciesLabel.text = "\(userDefaults.choosenCurrency())/\(currency)"
            }
            let ratio = choosen[indexPath.row].ratio / userDefaults.choosenRatio()
            cell.ratioLabel.text = String(ratio)
                
            
        }
        
        cell.selectionStyle = .none
        return cell
    }

    func saveData(exchangeRates: [DownloadRates]) {
        
        let context = PersistenceService.context
        
        let fetchRequest: NSFetchRequest<ExchangeRates> = ExchangeRates.fetchRequest()
        do {
            let exchange = try PersistenceService.context.fetch(fetchRequest)
            for row in exchange {
                context.delete(row)
            }
            try(context.save())
            
        }
        catch let error {
            print(error)
        }
        
        for row in exchangeRates {
        let exchange = ExchangeRates(context: context)
        exchange.currency = row.currencies
        exchange.ratio = row.ratio!
        PersistenceService.saveContext()
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: Date())
        userDefaults.setLastUpdateDate(value: "\(date)")
        print("updated ", userDefaults.lastUpdateDate())
        viewDidLoad()
    }
    
    func checkForInternet() {
        let networkErrorAlert = UIAlertController().getNetworkErrorAlert {
            self.checkForInternet()
        }
        
        if networkErrorAlert != nil {
            if let window = UIApplication.shared.keyWindow {
                window.rootViewController?.present(networkErrorAlert!, animated: true, completion: nil)
            }
        }
        else {
            aiv.startAnimating()
            
            DownloadRates.fetchExchangeRates(completionHandler: { (exchangeRates) in
                self.exchangeRates = exchangeRates
                
                self.tableView.reloadData()
                self.aiv.stopAnimating()
            })
        }
    }
    
    @objc func pushToSettingsViewController() {
        if let window = UIApplication.shared.keyWindow {
            window.rootViewController = UINavigationController(rootViewController: SettingsViewController())
        }
    }
    
    let aiv = UIActivityIndicatorView(activityIndicatorStyle: .gray)
}

