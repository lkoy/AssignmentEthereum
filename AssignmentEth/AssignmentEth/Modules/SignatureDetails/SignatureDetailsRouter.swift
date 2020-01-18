//
//  SignatureDetailsRouter.swift
//  AssignmentEth
//
//  Created by ttg on 18/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import Foundation

protocol SignatureDetailsRouterProtocol: BaseRouterProtocol {

    func navigateBack()
}

class SignatureDetailsRouter: BaseRouter, SignatureDetailsRouterProtocol {

    func navigateBack() {
        navigationController?.popViewController(animated: true)
    }
}
