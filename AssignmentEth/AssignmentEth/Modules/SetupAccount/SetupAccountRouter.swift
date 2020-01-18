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
}

class SetupAccountRouter: BaseRouter, SetupAccountRouterProtocol {

    func navigateToAccountDetails(accountDetails: AppModels.AccountDetails) {
        
        navigationController?.setViewControllers([AccountDetailsBuilder.build(accountDetails: accountDetails)], animated: true)
    }
}
