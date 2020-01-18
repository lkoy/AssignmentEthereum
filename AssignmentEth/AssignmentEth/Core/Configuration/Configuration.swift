//
//  Configuration.swift
//  AssignmentEth
//
//  Created by Iglesias, Gustavo on 17/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import Foundation
import EthereumKit

struct AppConfiguration {
    
    let rinkeby: Rinkeby
    
    struct Rinkeby {
        let nodeEndpoint: String
        let etherscanAPIKey: String
        let network: Network
        let debugPrints: Bool
    }
}
