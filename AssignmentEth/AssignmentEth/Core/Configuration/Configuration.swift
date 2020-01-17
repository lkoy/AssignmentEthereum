//
//  Configuration.swift
//  AssignmentEth
//
//  Created by Iglesias, Gustavo on 17/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import Foundation

struct AppConfiguration {
    
    let rinkeby: Rinkeby
    
    struct Rinkeby {
        let apiUrl: String
        let apiKey: String
    }
}
