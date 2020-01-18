//
//  VerifyMessageBuilder.swift
//  AssignmentEth
//
//  Created by ttg on 18/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import Foundation
import UIKit.UIViewController

final class VerifyMessageBuilder: BaseBuilder {

    static func build() -> UIViewController {

        let viewController: VerifyMessageViewController = VerifyMessageViewController()
        let router: VerifyMessageRouter = VerifyMessageRouter(viewController: viewController)
        let presenter: VerifyMessagePresenter = VerifyMessagePresenter(viewController: viewController, router: router)
        viewController.presenter = presenter

        return viewController
    }

}
