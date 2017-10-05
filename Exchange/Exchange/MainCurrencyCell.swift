//
//  MainCurrencyCell.swift
//  Exchange
//
//  Created by Ерден on 05.10.17.
//  Copyright © 2017 Ерден. All rights reserved.
//

import UIKit
import SnapKit

class MainCurrencyCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(label)
        
        label.snp.makeConstraints { (make) in
            make.left.equalTo(4)
            make.right.equalTo(-4)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let label = UILabel()
    
}
