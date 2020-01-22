//
//  CodableKeychain.swift
//  AssignmentEth
//
//  Created by Iglesias, Gustavo on 17/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import Foundation

class CodableKeychain<T: Codable> {
    
    let keychain: Keychain
    
    init(keychain: Keychain) {
        self.keychain = keychain
    }
    
    func store(codable: T) throws {
        let encoder = JSONEncoder()
        let data = try encoder.encode(codable)
        try keychain.store(data: data)
    }
    
    func fetch() throws -> T {
        let data = try keychain.fetch()
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
    
    func delete() throws {
        try keychain.delete()
    }
    
}
