//
//  SplashPresenter.swift
//  AssignmentMoneyou
//
//  Created by ttg on 22/09/2019.
//  Copyright © 2019 ttg. All rights reserved.
//

import Foundation

protocol SplashViewControllerProtocol: BaseViewControllerProtocol {

}

protocol SplashPresenterProtocol: BasePresenterProtocol {
    
    func checkRegistrationStatus()
}

final class SplashPresenter<T: SplashViewControllerProtocol, U: SplashRouterProtocol>: BasePresenter<T, U> {
    
    private let checkStateInteractor: CheckStateInteractorProtocol

    init(viewController: T, router: U, checkStateInteractor: CheckStateInteractorProtocol) {
        
        self.checkStateInteractor = checkStateInteractor
        super.init(viewController: viewController, router: router)
    }
    
}

extension SplashPresenter: SplashPresenterProtocol {
    
    func checkRegistrationStatus() {
        registrationStatus()
    }
}

extension SplashPresenter {
    
    private func registrationStatus() {
        checkStateInteractor.getState()
    }
}

extension SplashPresenter: CheckStateInteractorCallbackProtocol {
    
    func showError(type: CheckStateInteractorError) {
        
        print("error")
    }
    
    func userRegistered(_ registered: Bool) {
        if registered {
            router.navigateToSetupAccount()
        } else {
            router.navigateToSetupAccount()
        }
    }
}
