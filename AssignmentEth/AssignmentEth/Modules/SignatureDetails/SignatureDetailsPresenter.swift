//
//  SignatureDetailsPresenter.swift
//  AssignmentEth
//
//  Created by ttg on 18/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import Foundation

protocol SignatureDetailsViewControllerProtocol: BaseViewControllerProtocol {

    func showDetails(_ details: SignatureDetails.ViewModel)
}

protocol SignatureDetailsPresenterProtocol: BasePresenterProtocol {

    func prepareView()
    func backPressed()
}

final class SignatureDetailsPresenter<T: SignatureDetailsViewControllerProtocol, U: SignatureDetailsRouterProtocol>: BasePresenter<T, U> {

    private let signatureDetails: AppModels.MessageSigned
    private let mapper: SignatureDetailsMapper
    
    init(viewController: T, router: U, signatureDetails: AppModels.MessageSigned, signatureDetailsMapper: SignatureDetailsMapper) {
        
        self.signatureDetails = signatureDetails
        self.mapper = signatureDetailsMapper
        super.init(viewController: viewController, router: router)
    }
    
}

extension SignatureDetailsPresenter: SignatureDetailsPresenterProtocol {

    func prepareView() {
        
        self.viewController.showDetails(self.mapper.map(details: self.signatureDetails))
    }
    
    func backPressed() {
        router.navigateBack()
    }
}
