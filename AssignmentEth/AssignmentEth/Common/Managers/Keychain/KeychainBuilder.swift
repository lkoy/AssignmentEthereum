//
//  KeychainBuilder.swift
//  AssignmentEth
//
//  Created by Iglesias, Gustavo on 17/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

protocol KeychainBuilder {
    associatedtype Item: Codable
    static var accessGroup: String? { get }
    static var service: String { get }
    static var account: String { get }
    static func build() -> CodableKeychain<Item>
}

extension KeychainBuilder {
    
    static var accessGroup: String? {
        return nil
    }
    
    static func build() -> CodableKeychain<Item> {
        let keychain = Keychain(group: accessGroup, service: service, key: account)
        return CodableKeychain<Item>(keychain: keychain)
    }
}
