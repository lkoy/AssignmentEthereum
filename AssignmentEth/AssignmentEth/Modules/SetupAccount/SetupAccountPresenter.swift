//
//  SetupAccountPresenter.swift
//  AssignmentEth
//
//  Created by ttg on 17/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import Foundation

protocol SetupAccountViewControllerProtocol: BaseViewControllerProtocol {

    func showLoadingState()
    func hideLoadingState()
}

protocol SetupAccountPresenterProtocol: BasePresenterProtocol {

    func getDetails(forInput primaryKey: String)
}

final class SetupAccountPresenter<T: SetupAccountViewControllerProtocol, U: SetupAccountRouterProtocol>: BasePresenter<T, U> {

    var setupAccountInteractor : SetupAccountInteractorProtocol
    
    init(viewController: T, router: U, setupAccountInteractor: SetupAccountInteractorProtocol) {
        
        self.setupAccountInteractor = setupAccountInteractor
        super.init(viewController: viewController, router: router)
    }
    
}

extension SetupAccountPresenter: SetupAccountPresenterProtocol {

    func getDetails(forInput primaryKey: String) {
        
        self.viewController.showLoadingState()
        self.setupAccountInteractor.getAccountDetails(forPrimaryKey: primaryKey)
    }
}

extension SetupAccountPresenter: SetupAccountInteractorCallbackProtocol {

    func accoutObtained(accountDetails: AppModels.AccountDetails) {
        self.viewController.hideLoadingState()
        print("Account address: \(accountDetails.address) Weis: \(accountDetails.ether)")
        self.router.navigateToAccountDetails(accountDetails: accountDetails)
    }
    
    func showError() {
        self.viewController.hideLoadingState()
        
    }
}
