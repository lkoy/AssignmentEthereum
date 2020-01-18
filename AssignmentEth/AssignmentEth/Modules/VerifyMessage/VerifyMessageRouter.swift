//
//  VerifyMessageRouter.swift
//  AssignmentEth
//
//  Created by ttg on 18/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import Foundation

protocol VerifyMessageRouterProtocol: BaseRouterProtocol {

    func navigateBack()
}

class VerifyMessageRouter: BaseRouter, VerifyMessageRouterProtocol {

    func navigateBack() {
        navigationController?.popViewController(animated: true)
    }
}
