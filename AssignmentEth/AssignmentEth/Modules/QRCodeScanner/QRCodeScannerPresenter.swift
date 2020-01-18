//
//  QRCodeScannerPresenter.swift
//  AssignmentEth
//
//  Created by ttg on 18/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import Foundation

protocol QRCodeScannerViewControllerProtocol: BaseViewControllerProtocol {

}

protocol QRCodeScannerPresenterProtocol: BasePresenterProtocol {

    func backPressed()
}

final class QRCodeScannerPresenter<T: QRCodeScannerViewControllerProtocol, U: QRCodeScannerRouterProtocol>: BasePresenter<T, U> {

    private let messageToVerify: String
    
    init(viewController: T, router: U, message: String) {
        
        self.messageToVerify = message
        super.init(viewController: viewController, router: router)
    }
    
}

extension QRCodeScannerPresenter: QRCodeScannerPresenterProtocol {

    func backPressed() {
        router.navigateBack()
    }
}
