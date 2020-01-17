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
        
        let rinkeby = AppConfiguration.Rinkeby(apiUrl: "https://api.abanca.com/sandbox", apiKey: "6881a0b8-1c44-499e-b98b-c7c54f5ff889")
        
        return AppConfiguration(rinkeby: rinkeby)
    }
    
}
