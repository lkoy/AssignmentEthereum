//
//  VerifyMessagePresenter.swift
//  AssignmentEth
//
//  Created by ttg on 18/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import Foundation

protocol VerifyMessageViewControllerProtocol: BaseViewControllerProtocol {

}

protocol VerifyMessagePresenterProtocol: BasePresenterProtocol {

    func backPressed()
    func verifyMessage(_ message: String)
}

final class VerifyMessagePresenter<T: VerifyMessageViewControllerProtocol, U: VerifyMessageRouterProtocol>: BasePresenter<T, U> {

    override init(viewController: T, router: U) {
        
        super.init(viewController: viewController, router: router)
    }
    
}

extension VerifyMessagePresenter: VerifyMessagePresenterProtocol {

    func backPressed() {
        
        router.navigateBack()
    }
    
    func verifyMessage(_ message: String) {
        
        self.router.navigateToQRReader(withMessage: message)
    }
}
