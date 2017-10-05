//
//  ExchangeRates.swift
//  Exchange
//
//  Created by Ерден on 04.10.17.
//  Copyright © 2017 Ерден. All rights reserved.
//

import AlamofireDomain
import SwiftyJSON
import SVProgressHUD

class DownloadRates: NSObject {
    
    var currencies: String?
    var ratio: Float?
    
    static func fetchExchangeRates(completionHandler: @escaping ([DownloadRates]) -> ()) {
        
        let indicator = SVProgressHUD.self
        indicator.show()
        indicator.setDefaultMaskType(.black)
        indicator.setForegroundColor(.gray)
        var exchangeRates = [DownloadRates]()
        
        let URL = "http://finance.yahoo.com/webservice/v1/symbols/allcurrencies/quote?format=json"
        
        
        AlamofireDomain.request(URL, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    let result = json["list"]["resources"]
                    
                    for row in result.arrayValue {
                        let exchangeRate = DownloadRates()
                        var currency = row["resource"]["fields"]["symbol"].stringValue
                        let range = currency.index(currency.endIndex, offsetBy: -2)..<currency.endIndex
                        currency.removeSubrange(range)
                        exchangeRate.currencies = currency
                        exchangeRate.ratio = row["resource"]["fields"]["price"].floatValue
                        exchangeRates.append(exchangeRate)
                        
                    }
                }
                completionHandler(exchangeRates)
                SVProgressHUD.self.dismiss()
            case .failure(let error):
                print(error.localizedDescription)
                
                SVProgressHUD.self.dismiss()
                
                let alert = UIAlertController(title: "Server error", message: "Try later", preferredStyle: .alert)
                let confirmAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
                alert.addAction(confirmAction)
                if let window = UIApplication.shared.keyWindow {
                    window.rootViewController?.present(alert, animated: true, completion: nil)
                }
                
                
            }
        }
        
    }
}
