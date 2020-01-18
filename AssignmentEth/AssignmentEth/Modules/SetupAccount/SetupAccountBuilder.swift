//
//  SetupAccountBuilder.swift
//  AssignmentEth
//
//  Created by ttg on 17/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import Foundation
import UIKit.UIViewController

final class SetupAccountBuilder: BaseBuilder {

    static func build() -> UIViewController {

        let viewController: SetupAccountViewController = SetupAccountViewController()
        let router: SetupAccountRouter = SetupAccountRouter(viewController: viewController)
        let setupAccountInteractor: SetupAccountInteractor = SetupAccountInteractor()
        
        let presenter: SetupAccountPresenter = SetupAccountPresenter(viewController: viewController, router: router, setupAccountInteractor: setupAccountInteractor)
        viewController.presenter = presenter
        setupAccountInteractor.presenter = presenter

        return viewController
    }

}
