//
//  SignMessageRouter.swift
//  AssignmentEth
//
//  Created by ttg on 18/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import Foundation

protocol SignMessageRouterProtocol: BaseRouterProtocol {

    func navigateBack()
    func navigateToSignatureDetails(details: AppModels.MessageSigned)
}

class SignMessageRouter: BaseRouter, SignMessageRouterProtocol {

    func navigateBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func navigateToSignatureDetails(details: AppModels.MessageSigned) {
        navigationController?.pushViewController(SignatureDetailsBuilder.build(signatureDetails: details), animated: true)
    }
}
