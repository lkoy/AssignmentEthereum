//
//  QRCodeScannerRouter.swift
//  AssignmentEth
//
//  Created by ttg on 18/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import Foundation

protocol QRCodeScannerRouterProtocol: BaseRouterProtocol {

    func navigateBack()
    func navigateToAlert(title: String, message: String, primaryAction: ((DialogAction) -> Void)?)
}

class QRCodeScannerRouter: BaseRouter, QRCodeScannerRouterProtocol {

    func navigateBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func navigateToAlert(title: String, message: String, primaryAction: ((DialogAction) -> Void)?) {
        let dialog = DialogController(title: title,
                                      message: message,
                                      style: .alert)
        
        dialog.addAction(DialogAction(title: NSLocalizedString("ok_button", comment: "Ok button text"),
                                      style: .primary,
                                      handler: primaryAction))
        
        self.viewController.present(dialog, animated: true, completion: nil)
    }
}
