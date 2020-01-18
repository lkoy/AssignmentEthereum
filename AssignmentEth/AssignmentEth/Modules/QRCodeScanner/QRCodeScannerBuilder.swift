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

    static func build(message: String) -> UIViewController {

        let viewController: QRCodeScannerViewController = QRCodeScannerViewController()
        let router: QRCodeScannerRouter = QRCodeScannerRouter(viewController: viewController)
        
        let presenter: QRCodeScannerPresenter = QRCodeScannerPresenter(viewController: viewController, router: router, message: message)
        viewController.presenter = presenter

        return viewController
    }

}
