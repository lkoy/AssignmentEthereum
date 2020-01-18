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
}

class QRCodeScannerRouter: BaseRouter, QRCodeScannerRouterProtocol {

    func navigateBack() {
        navigationController?.popViewController(animated: true)
    }
}
