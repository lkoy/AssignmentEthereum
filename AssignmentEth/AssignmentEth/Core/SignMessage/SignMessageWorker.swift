//
//  SignMessageWorker.swift
//  AssignmentEth
//
//  Created by ttg on 18/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import Foundation
import EthereumKit

public struct SignMessageParameters {
    let privateKey: String
    let message: String
}

typealias SignMessageWorkerAlias = BaseWorker<SignMessageParameters, Result<AppModels.MessageSigned>>

final class SignMessageWorker: SignMessageWorkerAlias {
    
    private var wallet: Wallet!
    
    override func job(input: SignMessageParameters, completion: @escaping ((Result<AppModels.MessageSigned>) -> Void)) {
        
        wallet = Wallet(network: .rinkeby, privateKey: input.privateKey, debugPrints: provider.configuration.rinkeby.debugPrints)
        
        do {
            let messageSigned = try wallet.personalSign(message: input.message)
            completion(.success(AppModels.MessageSigned(message: input.message,
                                                        signedMessage: messageSigned)))
        } catch let error {
            completion(.failure(error as! EthereumKitError))
        }
    }

}
