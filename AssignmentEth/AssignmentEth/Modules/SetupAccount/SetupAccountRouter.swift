//
//  SetupAccountRouter.swift
//  AssignmentEth
//
//  Created by ttg on 17/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import Foundation

protocol SetupAccountRouterProtocol: BaseRouterProtocol {

    func navigateToAccountDetails(accountDetails: AppModels.AccountDetails)
    func navigateToAlert(title: String, message: String, primaryAction: ((DialogAction) -> Void)?)
}

class SetupAccountRouter: BaseRouter, SetupAccountRouterProtocol {

    func navigateToAccountDetails(accountDetails: AppModels.AccountDetails) {
        
        navigationController?.setViewControllers([AccountDetailsBuilder.build(accountDetails: accountDetails)], animated: true)
    }
    
    func navigateToAlert(title: String, message: String, primaryAction: ((DialogAction) -> Void)?) {
        let dialog = DialogController(title: title,
                                      message: message,
                                      style: .alert,
                                      isDismissableWhenTappingOut: true)
        
        dialog.addAction(DialogAction(title: "Ok",
                                      style: .primary,
                                      handler: primaryAction))
        
        self.viewController.present(dialog, animated: true, completion: nil)
    }
}
