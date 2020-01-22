//
//  ConfigurationBuilder.swift
//  AssignmentEth
//
//  Created by Iglesias, Gustavo on 17/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import Foundation

class ConfigurationBuilder {
    
    static func build() -> AppConfiguration {
        
        let rinkeby = AppConfiguration.Rinkeby(nodeEndpoint: "https://rinkeby.infura.io/v3/0903bd90102540bb878e8d917778352a",
                                               etherscanAPIKey: "TBQWJE1Z1Q8U4IBMTGMFN4RADS79Z36N8U",
                                               network: .rinkeby,
                                               debugPrints: true)
        
        return AppConfiguration(rinkeby: rinkeby)
    }
    
}
