//
//  AccountDetailsRouter.swift
//  AssignmentEth
//
//  Created by ttg on 18/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import Foundation

protocol AccountDetailsRouterProtocol: BaseRouterProtocol {

    func navigateToSignMessage()
    func navigateToVerifyMessage()
}

class AccountDetailsRouter: BaseRouter, AccountDetailsRouterProtocol {

    func navigateToSignMessage() {
        
        navigationController?.pushViewController(SignMessageBuilder.build(), animated: true)
    }
    
    func navigateToVerifyMessage() {
        navigationController?.pushViewController(VerifyMessageBuilder.build(), animated: true)
    }
}
