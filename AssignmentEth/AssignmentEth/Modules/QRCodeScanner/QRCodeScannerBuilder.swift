//
//  QRCodeScannerBuilder.swift
//  AssignmentEth
//
//  Created by ttg on 18/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import Foundation
import UIKit.UIViewController

final class QRCodeScannerBuilder: BaseBuilder {
    
    private var camera: CameraPermissionStatus = UIApplication.provider.camera

    func build(message: String) -> UIViewController {

        let viewController: QRCodeScannerViewController = QRCodeScannerViewController()
        let router: QRCodeScannerRouter = QRCodeScannerRouter(viewController: viewController)
        let qrScanningInteractor = QrScanningInteractor(worker: QrMapperWorker(), camera: self.camera)
        let verifyMessageInteractor = VerifyMessageInteractor()
        
        let presenter: QRCodeScannerPresenter = QRCodeScannerPresenter(viewController: viewController, router: router, message: message, qrScanningInteractor: qrScanningInteractor, verifyMessageInteractor: verifyMessageInteractor)
        viewController.presenter = presenter
        qrScanningInteractor.presenter = presenter
        verifyMessageInteractor.presenter = presenter

        return viewController
    }

}
