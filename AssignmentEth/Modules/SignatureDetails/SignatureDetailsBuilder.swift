//
//  SignatureDetailsBuilder.swift
//  AssignmentEth
//
//  Created by ttg on 18/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import Foundation
import UIKit.UIViewController

final class SignatureDetailsBuilder: BaseBuilder {

    static func build(signatureDetails: AppModels.MessageSigned) -> UIViewController {

        let viewController: SignatureDetailsViewController = SignatureDetailsViewController()
        let router: SignatureDetailsRouter = SignatureDetailsRouter(viewController: viewController)
        let mapper: SignatureDetailsMapper = SignatureDetailsMapper()
        
        let presenter: SignatureDetailsPresenter = SignatureDetailsPresenter(viewController: viewController, router: router, signatureDetails: signatureDetails, signatureDetailsMapper: mapper)
        viewController.presenter = presenter

        return viewController
    }

}
