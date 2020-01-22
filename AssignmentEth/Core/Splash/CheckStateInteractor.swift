//
//  GetAccountInteractor.swift
//  AssignmentMoneyou
//
//  Created by ttg on 23/09/2019.
//  Copyright © 2019 ttg. All rights reserved.
//

import Foundation

enum CheckStateInteractorError {
    case noData
    case showError
}

protocol CheckStateInteractorProtocol: BaseInteractorProtocol {
    func getState()
}

protocol CheckStateInteractorCallbackProtocol: BaseInteractorCallbackProtocol {

    func userRegistered(_ registered: Bool)
    func showError(type: CheckStateInteractorError)
}

class CheckStateInteractor: BaseInteractor {

    weak var presenter: CheckStateInteractorCallbackProtocol!
    private let checkStateWorker: CheckStateWorkerAlias

    init(checkStatusWorker: CheckStateWorkerAlias = CheckStateWorker()) {
        self.checkStateWorker = checkStatusWorker
        super.init()
    }
}

extension CheckStateInteractor: CheckStateInteractorProtocol {
    
    func getState() {
        
        //Execute worker in another thread to show splash screen
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
        guard let self = self else {
          return
        }
            self.checkStateWorker.execute { [weak self] (result) in
                
                guard let self = self else { return }
                
                switch result {
                case .success(let logedIn):
                    self.presenter.userRegistered(logedIn)
                case .failure:
                    self.presenter.showError(type: CheckStateInteractorError.showError)
                }
            }
        }
    }
}
