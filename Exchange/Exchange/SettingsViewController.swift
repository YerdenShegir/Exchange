//
//  SettingsViewController.swift
//  Exchange
//
//  Created by Ерден on 05.10.17.
//  Copyright © 2017 Ерден. All rights reserved.
//

import UIKit
import SnapKit

class SettingsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(chooseMainCurrencyButton)
        view.addSubview(chooseInterestedCurrenciesButton)
        view.addSubview(backToMainButton)
        
        chooseInterestedCurrenciesButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(chooseMainCurrencyButton.snp.top).offset(-4)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(view.snp.width).multipliedBy(0.7)
            make.height.equalTo(chooseInterestedCurrenciesButton.snp.width).multipliedBy(0.23)
        }
        
        chooseMainCurrencyButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(view.snp.centerY)
            make.width.equalTo(chooseInterestedCurrenciesButton.snp.width)
            make.centerX.equalTo(chooseInterestedCurrenciesButton.snp.centerX)
            make.height.equalTo(chooseInterestedCurrenciesButton.snp.height)
        }
        backToMainButton.snp.makeConstraints { (make) in
            make.top.equalTo(chooseMainCurrencyButton.snp.bottom).offset(4)
            make.width.equalTo(chooseInterestedCurrenciesButton.snp.width)
            make.centerX.equalTo(chooseInterestedCurrenciesButton.snp.centerX)
            make.height.equalTo(chooseInterestedCurrenciesButton.snp.height)
        }
        
        chooseMainCurrencyButton.addTarget(self, action: #selector(pushToMainCurrencyViewController), for: .touchUpInside)
        chooseInterestedCurrenciesButton.addTarget(self, action: #selector(pushToChoosenCurrenciesViewController), for: .touchUpInside)
        backToMainButton.addTarget(self, action: #selector(backToMain), for: .touchUpInside)
    }
    
    let chooseMainCurrencyButton = SettingsViewController.addButton(withTitle: "Изменить основную валюту")
    let chooseInterestedCurrenciesButton = SettingsViewController.addButton(withTitle: "Выбрать интересующие валюты")
    let backToMainButton = SettingsViewController.addButton(withTitle: "К списку курсов валют")
    
    static func addButton(withTitle title: String?) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        return button
    }
    
    @objc func pushToMainCurrencyViewController() {
        let mainCurrencyVC = MainCurrencyViewController()
        navigationController?.pushViewController(mainCurrencyVC, animated: true)
    }
    
    @objc func pushToChoosenCurrenciesViewController() {
        let choosenCurrenciesVC = ChoosenCurrenciesViewController()
        navigationController?.pushViewController(choosenCurrenciesVC, animated: true)
    }
    
    @objc func backToMain() {
        if let window = UIApplication.shared.keyWindow {
            window.rootViewController = UINavigationController(rootViewController: MainViewController())
        }
    }
}
