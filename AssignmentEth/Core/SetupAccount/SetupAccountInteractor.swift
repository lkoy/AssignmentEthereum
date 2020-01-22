//
//  SetupAccountInteractor.swift
//  AssignmentEth
//
//  Created by ttg on 18/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import Foundation

enum SetupAccountInteractorError {
    case storePrivateKeyError
    case getAccountError
}

protocol SetupAccountInteractorProtocol: BaseInteractorProtocol {

    func getAccountDetails(forPrivateKey privateKey:String)
}

protocol SetupAccountInteractorCallbackProtocol: BaseInteractorCallbackProtocol {

    func accoutObtained(accountDetails: AppModels.AccountDetails)
    func showError(_ error: SetupAccountInteractorError)
}

class SetupAccountInteractor: BaseInteractor {

    weak var presenter: SetupAccountInteractorCallbackProtocol!
    private let worker: SetupAccountWorkerAlias
    private let privateKeyKeychain: CodableKeychain<AppModels.PrivateKeyApp>

    init(withSetupAccountWorker worker: SetupAccountWorkerAlias = SetupAccountWorker(), keyChain: CodableKeychain<AppModels.PrivateKeyApp> = PrivateKeyKeychainBuilder.build()) {
        
        self.worker = worker
        self.privateKeyKeychain = keyChain
        super.init()
    }
    
    private func storeAndReturn(accountDetails: AppModels.AccountDetails, privateKey: String) {
        
        do {
            try privateKeyKeychain.store(codable: AppModels.PrivateKeyApp(pritateKey: privateKey))
                self.presenter.accoutObtained(accountDetails: accountDetails)
        } catch {
            self.presenter.showError(.storePrivateKeyError)
        }
    }
}

extension SetupAccountInteractor: SetupAccountInteractorProtocol {

    func getAccountDetails(forPrivateKey privateKey:String) {
        
        self.worker.execute(input: privateKey) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let accountDetails):
                self.storeAndReturn(accountDetails: accountDetails, privateKey: privateKey)
            case .failure:
                self.presenter.showError(.getAccountError)
            }
        }
    }
}
