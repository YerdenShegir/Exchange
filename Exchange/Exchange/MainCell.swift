//
//  MainCell.swift
//  Exchange
//
//  Created by Ерден on 04.10.17.
//  Copyright © 2017 Ерден. All rights reserved.
//

import UIKit
import SnapKit

class MainCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(currenciesLabel)
        addSubview(ratioLabel)
        
        
        currenciesLabel.snp.makeConstraints { (make) in
            make.left.equalTo(8)
            make.top.equalTo(4)
            make.bottom.equalTo(-4)
            make.width.equalTo(self).multipliedBy(0.4)
        }
        
        ratioLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-8)
            make.centerY.equalTo(currenciesLabel.snp.centerY)
            make.left.equalTo(currenciesLabel.snp.right)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


let currenciesLabel = MainCell.addLabel(withTextAlignement: .left)
let ratioLabel = MainCell.addLabel(withTextAlignement: .right)

static func addLabel(withTextAlignement alignment: NSTextAlignment) -> UILabel {
    let label = UILabel()
    label.textAlignment = alignment
    return label
}
    
    
}
