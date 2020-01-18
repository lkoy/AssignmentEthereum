//
//  SetupAccountWorker.swift
//  AssignmentEth
//
//  Created by ttg on 18/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import Foundation
import EthereumKit

typealias SetupAccountWorkerAlias = BaseWorker<String, Result<AppModels.AccountDetails>>

final class SetupAccountWorker: SetupAccountWorkerAlias {

    private let privateKeyKeychain: CodableKeychain<AppModels.PrivateKeyApp>
    private var wallet: Wallet!
    
    init(privateKeyKeychain: CodableKeychain<AppModels.PrivateKeyApp> = PrivateKeyKeychainBuilder.build()) {

        self.privateKeyKeychain = privateKeyKeychain
        super.init()
    }
    
    override func job(input: String, completion: @escaping ((Result<AppModels.AccountDetails>) -> Void)) {
        
        wallet = Wallet(network: .rinkeby, privateKey: input, debugPrints: provider.configuration.rinkeby.debugPrints)

        let configuration = Configuration(
            network: provider.configuration.rinkeby.network,
            nodeEndpoint: provider.configuration.rinkeby.nodeEndpoint,
            etherscanAPIKey: provider.configuration.rinkeby.etherscanAPIKey,
            debugPrints: provider.configuration.rinkeby.debugPrints
        )

        let geth = Geth(configuration: configuration)

        // To get a balance of an address, call `getBalance`.
        geth.getBalance(of: wallet.address(), blockParameter: .latest) { result in
            switch result {
            case .success(let balance):
                do {
                    let ether = try balance.ether()
                    self.store(account: AppModels.AccountDetails(address: self.wallet.address(), ether: ether),
                    privateKey: AppModels.PrivateKeyApp(pritateKey: input),
                    andHandle: completion)
                } catch {
                    completion(.failure(.convertError(.failedToConvert(balance.wei))))
                }
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }

    private func store(account: AppModels.AccountDetails, privateKey: AppModels.PrivateKeyApp, andHandle completion: @escaping ((Result<AppModels.AccountDetails>) -> Void)) {
        do {
            try privateKeyKeychain.store(codable: privateKey)
            completion(Result.success(account))
        } catch {
            completion(.failure(.cryptoError(.failedToSign)))
        }
    }
}
