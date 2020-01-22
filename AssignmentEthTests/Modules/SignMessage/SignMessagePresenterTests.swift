//
//  SignMessagePresenterTests.swift
//  AssignmentEthTests
//
//  Created by Iglesias, Gustavo on 20/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import XCTest
import Nimble

@testable import AssignmentEth

class SignMessagePresenterTests: XCTestCase {

    private var sut: SignMessagePresenter<ViewControllerSpy, RouterSpy>!
    private var viewControllerSpy: ViewControllerSpy!
    private var signMessagetInteractor: MockSignMessageInteractor!
    private var routerSpy: RouterSpy!
    
    override func setUp() {
        
        super.setUp()
        sut = givenSut()
    }

    override func tearDown() {
        
        viewControllerSpy = nil
        routerSpy = nil
        signMessagetInteractor = nil
        sut = nil
        super.tearDown()
    }

    func test_given_message_signed_then_navigate_signature_details() {
        
        signMessagetInteractor.stubSignedMessageFor(self.sut.messageSigned(AppModels.MessageSigned(message: "message", signedMessage: "signed_message")))
        
        sut.singMessage("message")

        expect(self.routerSpy.navigateToSignatureDetailsCalled).toEventually(equal(1))
    }
    
    func test_given_message_signed_failure_then_navigate_show_alert() {
        
        signMessagetInteractor.stubSignedMessageFor(self.sut.show(error: .signMessageError))
        
        sut.singMessage("message")

        expect(self.routerSpy.navigateToAlertCalled).toEventually(equal(1))
    }
    
    func test_given_back_presed_then_navigate_back() {
        
        sut.backPressed()

        expect(self.routerSpy.navigateBackCalled).toEventually(equal(1))
    }
    
    private func givenSut() -> SignMessagePresenter<ViewControllerSpy, RouterSpy> {
        viewControllerSpy = ViewControllerSpy()
        routerSpy = RouterSpy()
        signMessagetInteractor = MockSignMessageInteractor()
        
        let sut = SignMessagePresenter(viewController: viewControllerSpy, router: routerSpy, signMessageInteractor: signMessagetInteractor)

        return sut
    }
}

private class ViewControllerSpy: SignMessageViewControllerProtocol {

}

private class RouterSpy: SignMessageRouterProtocol {
    
    var navigateBackCalled: Int = 0
    var navigateToSignatureDetailsCalled: Int = 0
    var navigateToAlertCalled: Int = 0
    
    func navigateBack() {
        
        navigateBackCalled += 1
    }
    
    func navigateToSignatureDetails(details: AppModels.MessageSigned) {
        
        navigateToSignatureDetailsCalled += 1
    }
    
    func navigateToAlert(title: String, message: String, primaryAction: ((DialogAction) -> Void)?) {
        
        navigateToAlertCalled += 1
    }
}

private class MockSignMessageInteractor: SignMessageInteractorProtocol {
    
    var signedMessageFunction: (() -> Void)!

    func stubSignedMessageFor(_ f: @autoclosure @escaping (() -> Void)) {
        self.signedMessageFunction = f
    }
    
    func signMessage(_ message: String) {
        
        signedMessageFunction()
    }
}
