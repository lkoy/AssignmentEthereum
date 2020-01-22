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
        
        // Per EthereumKit framework check signature to avoid crashes
        // Note, the produced signature conforms to the secp256k1 curve R, S and V values,
        // Check is signature lenght is the correct
        let sig = Data(hex: input.signature)
        guard sig.count == 65 else {
            completion(.success(false))
            return
        }
        
        // Per EthereumKit framework check signature to avoid crashes
        // PersonalSigned method
        // Note, the produced signature conforms to the secp256k1 curve R, S and V values,
        // where the V value will be 27 or 28 for legacy reasons.
        if sig[64] != 27 && sig[64] != 28 {
            completion(.success(false))
            return
        }
        
        wallet = Wallet(network: .rinkeby, privateKey: input.privateKey, debugPrints: provider.configuration.rinkeby.debugPrints)
        
        completion(.success(wallet.verify(personalSigned: input.signature, message: input.message)))
    }

}
