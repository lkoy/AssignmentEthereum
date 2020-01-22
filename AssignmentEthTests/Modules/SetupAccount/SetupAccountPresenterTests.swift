//
//  SetupAccountPresenterTests.swift
//  AssignmentEthTests
//
//  Created by Iglesias, Gustavo on 19/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import XCTest
import Nimble

@testable import AssignmentEth

class SetupAccountPresenterTests: XCTestCase {

    private var sut: SetupAccountPresenter<ViewControllerSpy, RouterSpy>!
    private var viewControllerSpy: ViewControllerSpy!
    private var setupAccountInteractor: MockSetupAccountInteractor!
    private var routerSpy: RouterSpy!
    
    override func setUp() {
        
        super.setUp()
        sut = givenSut()
    }

    override func tearDown() {
        
        viewControllerSpy = nil
        routerSpy = nil
        setupAccountInteractor = nil
        sut = nil
        super.tearDown()
    }

    func test_given_account_details_found_then_navigate_account_details() {
        
        setupAccountInteractor.stubGetAccountDetailsFor(self.sut.accoutObtained(accountDetails: AppModels.AccountDetails(address: "", ether: 0)))
        
        sut.getDetails(forInput: "Private Key")
        expect(self.viewControllerSpy.showLoadingStateCalled).toEventually(equal(1))
        expect(self.routerSpy.navigateToAccountDetailsCalled).toEventually(equal(1))
        expect(self.viewControllerSpy.hideLoadingStateCalled).toEventually(equal(1))
        expect(self.routerSpy.navigateToAlertCalled).toEventually(equal(0))
    }
    
    func test_given_account_details_not_found_then_show_alert() {
        
        setupAccountInteractor.stubGetAccountDetailsFor(self.sut.showError(.storePrivateKeyError))
        
        sut.getDetails(forInput: "Private Key")
        expect(self.viewControllerSpy.showLoadingStateCalled).toEventually(equal(1))
        expect(self.routerSpy.navigateToAlertCalled).toEventually(equal(1))
        expect(self.viewControllerSpy.hideLoadingStateCalled).toEventually(equal(1))
    }
    
    private func givenSut() -> SetupAccountPresenter<ViewControllerSpy, RouterSpy> {
        viewControllerSpy = ViewControllerSpy()
        routerSpy = RouterSpy()
        setupAccountInteractor = MockSetupAccountInteractor()
        
        let sut = SetupAccountPresenter(viewController: viewControllerSpy, router: routerSpy, setupAccountInteractor: setupAccountInteractor)

        return sut
    }
}

private class ViewControllerSpy: SetupAccountViewControllerProtocol {

    var showLoadingStateCalled: Int = 0
    var hideLoadingStateCalled: Int = 0
    
    func showLoadingState() {
        
        showLoadingStateCalled += 1
    }
    
    func hideLoadingState() {
        
        hideLoadingStateCalled += 1
    }
}

private class RouterSpy: SetupAccountRouterProtocol {
    
    var navigateToAccountDetailsCalled: Int = 0
    var navigateToAlertCalled: Int = 0
    
    func navigateToAccountDetails(accountDetails: AppModels.AccountDetails) {
        
        navigateToAccountDetailsCalled += 1
    }
    
    func navigateToAlert(title: String, message: String, primaryAction: ((DialogAction) -> Void)?) {
        
        navigateToAlertCalled += 1
    }
}

private class MockSetupAccountInteractor: SetupAccountInteractorProtocol {
    
    var getAccountDetailsFunction: (() -> Void)!

    func stubGetAccountDetailsFor(_ f: @autoclosure @escaping (() -> Void)) {
        self.getAccountDetailsFunction = f
    }
    
    func getAccountDetails(forPrivateKey privateKey:String) {
        
        getAccountDetailsFunction()
    }
}
