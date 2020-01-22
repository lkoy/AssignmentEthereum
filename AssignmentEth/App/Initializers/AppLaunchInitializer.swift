//
//  AppLaunchInitializer.swift
//  AssignmentEth
//
//  Created by Iglesias, Gustavo on 19/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import Foundation

class AppLaunchInitializer: Initializable {
    
    private let privatekeyKeychain: CodableKeychain<AppModels.PrivateKeyApp>
    
    init(privatekeyKeychain: CodableKeychain<AppModels.PrivateKeyApp> = PrivateKeyKeychainBuilder.build()) {
        
        self.privatekeyKeychain = privatekeyKeychain
    }
    
    func initialize() {
        try? privatekeyKeychain.delete()
    }
    
}
