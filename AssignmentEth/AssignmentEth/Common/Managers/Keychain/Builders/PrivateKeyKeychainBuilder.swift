//
//  PrivateKeyKeychainBuilder.swift
//  AssignmentEth
//
//  Created by Iglesias, Gustavo on 17/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import Foundation

enum PrivateKeyKeychainBuilder: KeychainBuilder {
    
    typealias Item = AppModels.PrivateKeyApp
    
    static var service: String {
        return "\(Bundle.identifier)"
    }
    
    static var account: String {
        return "privatekey-eth"
    }
    
    static func build() -> CodableKeychain<Item> {
        let keychain = Keychain(group: accessGroup, service: service, key: account)
        return CodableKeychain<Item>(keychain: keychain)
    }
    
}
