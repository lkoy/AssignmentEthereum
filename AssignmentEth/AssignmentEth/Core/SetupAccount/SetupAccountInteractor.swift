//
//  SetupAccountInteractor.swift
//  AssignmentEth
//
//  Created by ttg on 18/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import Foundation

protocol SetupAccountInteractorProtocol: BaseInteractorProtocol {

    func getAccountDetails(forPrimaryKey primaryKey:String)
}

protocol SetupAccountInteractorCallbackProtocol: BaseInteractorCallbackProtocol {

    func accoutObtained(accountDetails: AppModels.AccountDetails)
    func showError()
}

class SetupAccountInteractor: BaseInteractor {

    weak var presenter: SetupAccountInteractorCallbackProtocol!
    private let worker: SetupAccountWorkerAlias

    init(withSetupAccountWorker worker: SetupAccountWorkerAlias = SetupAccountWorker()) {
        self.worker = worker
        super.init()
    }
}

extension SetupAccountInteractor: SetupAccountInteractorProtocol {

    func getAccountDetails(forPrimaryKey primaryKey:String) {
        
        self.worker.execute(input: primaryKey) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let accountDetails):
                self.presenter.accoutObtained(accountDetails: accountDetails)
            case .failure:
                self.presenter.showError()
            }
        }
    }
}
