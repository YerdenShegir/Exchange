//
//  Connectivity.swift
//  Exchange
//
//  Created by Ерден on 04.10.17.
//  Copyright © 2017 Ерден. All rights reserved.
//

import Foundation
import AlamofireDomain

class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
