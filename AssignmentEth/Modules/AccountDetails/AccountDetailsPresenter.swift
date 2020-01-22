//
//  AccountDetailsPresenter.swift
//  AssignmentEth
//
//  Created by ttg on 18/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import Foundation

protocol AccountDetailsViewControllerProtocol: BaseViewControllerProtocol {
 
    func showAccountDetails(viewModel: AccountDetails.ViewModel)
}

protocol AccountDetailsPresenterProtocol: BasePresenterProtocol {

    func prepareView()
    func continueToSign()
    func continueToVerification()
}

final class AccountDetailsPresenter<T: AccountDetailsViewControllerProtocol, U: AccountDetailsRouterProtocol>: BasePresenter<T, U> {

    let accountDetails: AppModels.AccountDetails
    let accountDetailsMapper: AccountDetailsMapper
    
    init(viewController: T, router: U, accountDetails: AppModels.AccountDetails, accountDetailsMapper: AccountDetailsMapper) {
        
        self.accountDetails = accountDetails
        self.accountDetailsMapper = accountDetailsMapper
        super.init(viewController: viewController, router: router)
    }
    
}

extension AccountDetailsPresenter: AccountDetailsPresenterProtocol {

    func prepareView() {
        
        self.viewController.showAccountDetails(viewModel: accountDetailsMapper.map(account: self.accountDetails))
    }
    
    func continueToSign() {
        
        self.router.navigateToSignMessage()
    }
    
    func continueToVerification() {
        
        self.router.navigateToVerifyMessage()
    }
}
