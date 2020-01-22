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
    func navigateToAlert(title: String, message: String, primaryAction: ((DialogAction) -> Void)?)
}

class SignMessageRouter: BaseRouter, SignMessageRouterProtocol {

    func navigateBack() {
        
        navigationController?.popViewController(animated: true)
    }
    
    func navigateToSignatureDetails(details: AppModels.MessageSigned) {
        
        navigationController?.pushViewController(SignatureDetailsBuilder.build(signatureDetails: details), animated: true)
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
