//
//  ChoosenCurrenciesCell.swift
//  Exchange
//
//  Created by Ерден on 05.10.17.
//  Copyright © 2017 Ерден. All rights reserved.
//

import UIKit
import SnapKit

class ChoosenCurrenciesCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(label)
        addSubview(button)
        
        label.snp.makeConstraints { (make) in
            make.left.equalTo(4)
            make.width.equalTo(self).multipliedBy(0.7)
        }
        
        button.snp.makeConstraints { (make) in
            make.right.equalTo(-4)
            make.width.height.equalTo(label.snp.height)
            make.centerY.equalTo(label.snp.centerY)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let label = UILabel()
    let button = UIButton()
    
}
