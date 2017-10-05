//
//  ExchangeRates+CoreDataProperties.swift
//  Exchange
//
//  Created by Ерден on 05.10.17.
//  Copyright © 2017 Ерден. All rights reserved.
//
//

import Foundation
import CoreData


extension ExchangeRates {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExchangeRates> {
        return NSFetchRequest<ExchangeRates>(entityName: "ExchangeRates")
    }

    @NSManaged public var currency: String?
    @NSManaged public var ratio: Float

}
