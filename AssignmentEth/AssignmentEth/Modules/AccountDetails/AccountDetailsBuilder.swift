//
//  AccountDetailsBuilder.swift
//  AssignmentEth
//
//  Created by ttg on 18/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import Foundation
import UIKit.UIViewController

final class AccountDetailsBuilder: BaseBuilder {

    static func build(accountDetails: AppModels.AccountDetails) -> UIViewController {

        let viewController: AccountDetailsViewController = AccountDetailsViewController()
        let router: AccountDetailsRouter = AccountDetailsRouter(viewController: viewController)
        let mapper: AccountDetailsMapper = AccountDetailsMapper()
        
        let presenter: AccountDetailsPresenter = AccountDetailsPresenter(viewController: viewController, router: router, accountDetails: accountDetails, accountDetailsMapper: mapper)
        viewController.presenter = presenter

        return viewController
    }

}
