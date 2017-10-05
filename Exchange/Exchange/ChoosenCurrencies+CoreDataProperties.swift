//
//  ChoosenCurrencies+CoreDataProperties.swift
//  Exchange
//
//  Created by Ерден on 05.10.17.
//  Copyright © 2017 Ерден. All rights reserved.
//
//

import Foundation
import CoreData


extension ChoosenCurrencies {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChoosenCurrencies> {
        return NSFetchRequest<ChoosenCurrencies>(entityName: "ChoosenCurrencies")
    }

    @NSManaged public var currencies: String?
    @NSManaged public var ratio: Float

}
