//
//  VerifyMessageInteractor.swift
//  AssignmentEth
//
//  Created by ttg on 18/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import Foundation

enum VerifyMessageInteractorError {
    case fetchPrivateKeyError
    case verifyMessageError
}

protocol VerifyMessageInteractorProtocol: BaseInteractorProtocol {

    func verifyMessage(_ message: String, signature: String)
}

protocol VerifyMessageInteractorCallbackProtocol: BaseInteractorCallbackProtocol {

    func messageVerified(valid: Bool)
    func show(error: VerifyMessageInteractorError)
}

class VerifyMessageInteractor: BaseInteractor {

    weak var presenter: VerifyMessageInteractorCallbackProtocol!
    private let worker: VerifyMessageWorkerAlias
    private let privateKeyKeychain: CodableKeychain<AppModels.PrivateKeyApp>

    init(withVerifyMessageWorker worker: VerifyMessageWorkerAlias = VerifyMessageWorker(), keyChain: CodableKeychain<AppModels.PrivateKeyApp> = PrivateKeyKeychainBuilder.build()) {
        
        self.worker = worker
        self.privateKeyKeychain = keyChain
        super.init()
    }
}

extension VerifyMessageInteractor: VerifyMessageInteractorProtocol {

    func verifyMessage(_ message: String, signature: String) {
        
        guard let privateKey = try? self.privateKeyKeychain.fetch().pritateKey else {
            self.presenter.show(error: .fetchPrivateKeyError)
            return
        }
        
        let params = VerifyMessageParameters(privateKey: privateKey,
                                             message: message,
                                             signature: signature)
        self.worker.execute(input: params) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let verified):
                self.presenter.messageVerified(valid: verified)
            case .failure:
                self.presenter.show(error: .verifyMessageError)
            }
        }
    }
}
