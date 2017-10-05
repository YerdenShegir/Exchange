//
//  Extensions.swift
//  Exchange
//
//  Created by Ерден on 04.10.17.
//  Copyright © 2017 Ерден. All rights reserved.
//

import UIKit
import SVProgressHUD

let userDefaults = UserDefaults.standard

extension UIAlertController {
    
    func getNetworkErrorAlert(withAction action: @escaping () -> Void) -> UIAlertController? {
        if !Connectivity.isConnectedToInternet() {
            SVProgressHUD.self.dismiss()
            
            let alert = UIAlertController(title: "No internet-connection", message: "Data cannot be loaded", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "Try again", style: .default, handler: {
                Void in
                action()
            })
            alert.addAction(confirmAction)
            
            return alert
        }
        else {
            return nil
        }
    }
    
    func getServerErrorAlert() -> UIAlertController? {
        
        
        let alert = UIAlertController(title: "Server error", message: "Try again", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
        alert.addAction(confirmAction)
        
        return alert
    }
    
}

extension UserDefaults {
    
    enum UserDefaultsKeys: String {
        case isLaunchedBefore
        case choosenCurrency
        case lastUpdateDate
        case numberOfUpdates
        case choosenRatio
    }
    
    func setIsLaunchedBefore(value: Bool) {
        set(value, forKey: UserDefaultsKeys.isLaunchedBefore.rawValue)
    }
    
    func isLaunchedBefore() -> Bool {
        return bool(forKey: UserDefaultsKeys.isLaunchedBefore.rawValue)
    }
    
    func setСhoosenCurrency(value: String) {
        set(value, forKey: UserDefaultsKeys.choosenCurrency.rawValue)
    }
    
    func choosenCurrency() -> String {
        return string(forKey: UserDefaultsKeys.choosenCurrency.rawValue)!
    }
    
    func setChoosenRatio(value: Float) {
        set(value, forKey: UserDefaultsKeys.choosenRatio.rawValue)
    }
    
    func choosenRatio() -> Float {
        return float(forKey: UserDefaultsKeys.choosenRatio.rawValue)
    }
    
    func setLastUpdateDate(value: String) {
        set(value, forKey: UserDefaultsKeys.lastUpdateDate.rawValue)
    }
    
    func lastUpdateDate() -> String {
        return string(forKey: UserDefaultsKeys.lastUpdateDate.rawValue)!
    }
    
    func setNumberOfUpdates(value: Int) {
        set(value, forKey: UserDefaultsKeys.numberOfUpdates.rawValue)
    }
    
    func numberOfUpdates() -> Int {
        return integer(forKey: UserDefaultsKeys.numberOfUpdates.rawValue)
    }
}
