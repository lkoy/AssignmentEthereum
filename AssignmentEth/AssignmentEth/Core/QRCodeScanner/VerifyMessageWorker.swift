//
//  VerifyMessageWorker.swift
//  AssignmentEth
//
//  Created by ttg on 18/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import Foundation
import EthereumKit

public struct VerifyMessageParameters {
    let privateKey: String
    let message: String
    let signature: String
}

typealias VerifyMessageWorkerAlias = BaseWorker<VerifyMessageParameters, Result<Bool>>

final class VerifyMessageWorker: VerifyMessageWorkerAlias {
    
    private var wallet: Wallet!
    
    override func job(input: VerifyMessageParameters, completion: @escaping ((Result<Bool>) -> Void)) {
        
        wallet = Wallet(network: .rinkeby, privateKey: input.privateKey, debugPrints: provider.configuration.rinkeby.debugPrints)
        
        completion(.success(wallet.verify(personalSigned: input.signature, message: input.message)))
    }

}
