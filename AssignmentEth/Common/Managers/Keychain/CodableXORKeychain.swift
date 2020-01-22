//
//  CodableXORKeychain.swift
//  AssignmentEth
//
//  Created by Iglesias, Gustavo on 17/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import Foundation

class CodableXORKeychain<T: Codable>: CodableKeychain<T> {
    
    private let hash: String
    
    init(keychain: Keychain, hash: String) {
        self.hash = hash
        super.init(keychain: keychain)
    }
    
    override func store(codable: T) throws {
        let encoder = JSONEncoder()
        let data = try encoder.encode(codable)
        let encryptedData = Crypto.applyXOR(data, forHash: hash)
        try keychain.store(data: encryptedData)
    }
    
    override func fetch() throws -> T {
        let data = try keychain.fetch()
        let decryptedData = Crypto.applyXOR(data, forHash: hash)
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: decryptedData)
    }
    
}
