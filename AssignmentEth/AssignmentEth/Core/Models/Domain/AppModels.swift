//
//  AppModels.swift
//  AssignmentEth
//
//  Created by Iglesias, Gustavo on 17/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import Foundation

enum AppModels {
    
    struct PrivateKeyApp: Codable {
        let pritateKey: String?
    }
    
    struct AccountDetails: Codable {
        let address: String
        let ether: Decimal
    }
}
