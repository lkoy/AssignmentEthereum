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

    private var setupAccountInteractor : SetupAccountInteractorProtocol
    
    init(viewController: T, router: U, setupAccountInteractor: SetupAccountInteractorProtocol) {
        
        self.setupAccountInteractor = setupAccountInteractor
        super.init(viewController: viewController, router: router)
    }
    
}

extension SetupAccountPresenter: SetupAccountPresenterProtocol {

    func getDetails(forInput primaryKey: String) {
        
        self.viewController.showLoadingState()
        self.setupAccountInteractor.getAccountDetails(forPrivateKey: primaryKey)
    }
}

extension SetupAccountPresenter: SetupAccountInteractorCallbackProtocol {

    func accoutObtained(accountDetails: AppModels.AccountDetails) {
        
        self.viewController.hideLoadingState()
        self.router.navigateToAccountDetails(accountDetails: accountDetails)
    }
    
    func showError(_ error: SetupAccountInteractorError) {
        
        self.viewController.hideLoadingState()
        self.router.navigateToAlert(title: NSLocalizedString("error_alert_title", comment: "Error alert title"),
                                    message: NSLocalizedString("error_account_details_title", comment: "Account not found details"), primaryAction: nil)
    }
}
