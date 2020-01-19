//
//  SignMessagePresenter.swift
//  AssignmentEth
//
//  Created by ttg on 18/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import Foundation

protocol SignMessageViewControllerProtocol: BaseViewControllerProtocol {

}

protocol SignMessagePresenterProtocol: BasePresenterProtocol {

    func backPressed()
    func singMessage(_ message: String)
}

final class SignMessagePresenter<T: SignMessageViewControllerProtocol, U: SignMessageRouterProtocol>: BasePresenter<T, U> {

    private var signMessageInteractor: SignMessageInteractorProtocol
    
    init(viewController: T, router: U, signMessageInteractor: SignMessageInteractorProtocol) {
        
        self.signMessageInteractor = signMessageInteractor
        super.init(viewController: viewController, router: router)
    }
    
}

extension SignMessagePresenter: SignMessagePresenterProtocol {

    func backPressed() {
        router.navigateBack()
    }
    
    func singMessage(_ message: String) {
        
        signMessageInteractor.signMessage(message)
    }
}

extension SignMessagePresenter: SignMessageInteractorCallbackProtocol {
    
    func messageSigned(_ messageSigned: AppModels.MessageSigned) {
        
        self.router.navigateToSignatureDetails(details: messageSigned)
    }
    
    func show(error: SignMessageInteractorError) {
        
        self.router.navigateToAlert(title: "Error", message: "An error occurred singing message.", primaryAction: nil)
    }
}
