//
//  SplashRouter.swift
//  AssignmentMoneyou
//
//  Created by ttg on 22/09/2019.
//  Copyright © 2019 ttg. All rights reserved.
//

import Foundation

protocol SplashRouterProtocol: BaseRouterProtocol {

    func navigateToSetupAccount()
}

class SplashRouter: BaseRouter, SplashRouterProtocol {
    
    func navigateToSetupAccount() {
        
        navigationController?.setViewControllers([SetupAccountBuilder.build()], animated: true)
    }
}
