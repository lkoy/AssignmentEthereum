//
//  SplashRouter.swift
//  AssignmentMoneyou
//
//  Created by ttg on 22/09/2019.
//  Copyright © 2019 ttg. All rights reserved.
//

import Foundation

protocol SplashRouterProtocol: BaseRouterProtocol {

    func navigateToMobileVerification()
    func navigateToHome()
}

class SplashRouter: BaseRouter, SplashRouterProtocol {
    
    func navigateToMobileVerification() {
//        navigationController?.setViewControllers([MobileVerificationBuilder.build()], animated: true)
//        navigationController?.setViewControllers([SelectBankBuilder.build()], animated: true)
    }
    
    func navigateToHome() {
//        navigationController?.setViewControllers([HomeBuilder.build()], animated: true)
    }
}
