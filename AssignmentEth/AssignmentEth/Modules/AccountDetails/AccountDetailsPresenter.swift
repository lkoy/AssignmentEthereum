//
//  AccountDetailsPresenter.swift
//  AssignmentEth
//
//  Created by ttg on 18/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import Foundation

protocol AccountDetailsViewControllerProtocol: BaseViewControllerProtocol {

}

protocol AccountDetailsPresenterProtocol: BasePresenterProtocol {

}

final class AccountDetailsPresenter<T: AccountDetailsViewControllerProtocol, U: AccountDetailsRouterProtocol>: BasePresenter<T, U> {

    let accountDetails: AppModels.AccountDetails
    
    init(viewController: T, router: U, accountDetails: AppModels.AccountDetails) {
        
        self.accountDetails = accountDetails
        super.init(viewController: viewController, router: router)
    }
    
}

extension AccountDetailsPresenter: AccountDetailsPresenterProtocol {

}
