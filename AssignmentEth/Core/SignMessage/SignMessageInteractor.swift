//
//  SignMessageInteractor.swift
//  AssignmentEth
//
//  Created by ttg on 18/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import Foundation

enum SignMessageInteractorError {
    case fetchPrivateKeyError
    case signMessageError
}

protocol SignMessageInteractorProtocol: BaseInteractorProtocol {

    func signMessage(_ message: String)
}

protocol SignMessageInteractorCallbackProtocol: BaseInteractorCallbackProtocol {

    func messageSigned(_ messageSigned: AppModels.MessageSigned)
    func show(error: SignMessageInteractorError)
}

class SignMessageInteractor: BaseInteractor {

    weak var presenter: SignMessageInteractorCallbackProtocol!
    private let worker: SignMessageWorkerAlias
    private let privateKeyKeychain: CodableKeychain<AppModels.PrivateKeyApp>

    init(withSignMessageWorker worker: SignMessageWorkerAlias = SignMessageWorker(), keyChain: CodableKeychain<AppModels.PrivateKeyApp> = PrivateKeyKeychainBuilder.build()) {
        
        self.worker = worker
        self.privateKeyKeychain = keyChain
        super.init()
    }
}

extension SignMessageInteractor: SignMessageInteractorProtocol {

    func signMessage(_ message: String) {
        
        guard let privateKey = try? self.privateKeyKeychain.fetch().pritateKey else {
            self.presenter.show(error: .fetchPrivateKeyError)
            return
        }
        
        let params = SignMessageParameters(privateKey: privateKey,
                                          message: message)
        self.worker.execute(input: params) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let messageSigned):
                self.presenter.messageSigned(messageSigned)
            case .failure:
                self.presenter.show(error: .signMessageError)
            }
        }
    }
}
