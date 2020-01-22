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

    private var wallet: Wallet!
    
    override func job(input: String, completion: @escaping ((Result<AppModels.AccountDetails>) -> Void)) {
        
        wallet = Wallet(network: .rinkeby, privateKey: input, debugPrints: provider.configuration.rinkeby.debugPrints)

        let configuration = Configuration(
            network: provider.configuration.rinkeby.network,
            nodeEndpoint: provider.configuration.rinkeby.nodeEndpoint,
            etherscanAPIKey: provider.configuration.rinkeby.etherscanAPIKey,
            debugPrints: provider.configuration.rinkeby.debugPrints
        )

        let geth = Geth(configuration: configuration)

        geth.getBalance(of: wallet.address(), blockParameter: .latest) { result in
            switch result {
            case .success(let balance):
                do {
                    let ether = try balance.ether()
                    completion(Result.success(AppModels.AccountDetails(address: self.wallet.address(), ether: ether)))
                } catch {
                    completion(.failure(.convertError(.failedToConvert(balance.wei))))
                }
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
}
