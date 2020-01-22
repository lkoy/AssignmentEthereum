//
//  SignMessageBuilder.swift
//  AssignmentEth
//
//  Created by ttg on 18/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import Foundation
import UIKit.UIViewController

final class SignMessageBuilder: BaseBuilder {

    static func build() -> UIViewController {

        let viewController: SignMessageViewController = SignMessageViewController()
        let router: SignMessageRouter = SignMessageRouter(viewController: viewController)
        let signMessageInteractor: SignMessageInteractor = SignMessageInteractor()
        
        let presenter: SignMessagePresenter = SignMessagePresenter(viewController: viewController, router: router, signMessageInteractor: signMessageInteractor)
        viewController.presenter = presenter
        signMessageInteractor.presenter = presenter

        return viewController
    }

}
