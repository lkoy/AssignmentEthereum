//
//  RinkebyBaseNetworkService.swift
//  AssignmentEth
//
//  Created by Iglesias, Gustavo on 17/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import Foundation

protocol RinkebyBaseNetworkService: NetworkService {

}

extension RinkebyBaseNetworkService {

    var url: URL {
        return URL(string: provider.configuration.rinkeby.apiUrl)!
    }
}

enum RinkebyNetworkService {
    
    struct Config {
        static var apiKey: String {
            return provider.configuration.rinkeby.apiKey
        }
        static var maxNumberOfRetries = 1
    }
}
