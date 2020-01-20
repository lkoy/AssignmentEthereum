//
//  QRCodeScannerPresenterTests.swift
//  AssignmentEthTests
//
//  Created by Iglesias, Gustavo on 20/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import XCTest
import Nimble

@testable import AssignmentEth

class QRCodeScannerPresenterTests: XCTestCase {

    private var sut: QRCodeScannerPresenter<ViewControllerSpy, RouterSpy>!
    private var viewControllerSpy: ViewControllerSpy!
    private var qrScanningInteractor: MockQrScanningInteractor!
    private var verifyMessageInteractor: MockVerifyMessageInteractor!
    private var routerSpy: RouterSpy!
    
    override func setUp() {
        
        super.setUp()
        sut = givenSut()
    }

    override func tearDown() {
        
        viewControllerSpy = nil
        routerSpy = nil
        qrScanningInteractor = nil
        verifyMessageInteractor = nil
        sut = nil
        super.tearDown()
    }

    func test_given_camera_permision_not_determined_then_navigate_ask_camera_permissions() {
        
        qrScanningInteractor.stubQrScanningFunctionFor(self.sut.notDeterminedCameraPermissions())
        
        sut.prepareView()

        expect(self.viewControllerSpy.askForCameraPermissionsCalled).toEventually(equal(1))
    }
    
    func test_given_camera_permision_authorised_then_navigate_ask_camera_permissions() {
        
        qrScanningInteractor.stubQrScanningFunctionFor(self.sut.authorizedCameraPermissions())
        
        sut.prepareView()

        expect(self.viewControllerSpy.showVideoViewCalled).toEventually(equal(1))
    }
    
    func test_given_qr_found_with_message_valid_then_navigate_alert_valid() {
        
        qrScanningInteractor.stubQrScanningFunctionFor(self.sut.foundQR(signature: "signature"))
        verifyMessageInteractor.stubVerifyMessageFor(self.sut.messageVerified(valid: true))
        
        sut.readedQrs(["qr_readed"])

        expect(self.viewControllerSpy.signatureValidCalled).toEventually(equal(1))
        expect(self.routerSpy.navigateToAlertCalled).toEventually(equal(1))
    }
    
    func test_given_qr_found_with_message_invalid_then_navigate_alert_valid() {
        
        qrScanningInteractor.stubQrScanningFunctionFor(self.sut.foundQR(signature: "signature"))
        verifyMessageInteractor.stubVerifyMessageFor(self.sut.messageVerified(valid: false))
        
        sut.readedQrs(["qr_readed"])

        expect(self.viewControllerSpy.signatureInvalidCalled).toEventually(equal(1))
        expect(self.routerSpy.navigateToAlertCalled).toEventually(equal(1))
    }
    
    func test_given_invalid_qr_found_then_navigate_alert_valid() {
        
        qrScanningInteractor.stubQrScanningFunctionFor(self.sut.invalidQr())
        
        sut.readedQrs(["qr_readed"])

        expect(self.viewControllerSpy.stopScanningCalled).toEventually(equal(1))
        expect(self.routerSpy.navigateToAlertCalled).toEventually(equal(1))
    }
    
    private func givenSut() -> QRCodeScannerPresenter<ViewControllerSpy, RouterSpy> {
        viewControllerSpy = ViewControllerSpy()
        routerSpy = RouterSpy()
        qrScanningInteractor = MockQrScanningInteractor()
        verifyMessageInteractor = MockVerifyMessageInteractor()
        
        let sut = QRCodeScannerPresenter(viewController: viewControllerSpy, router: routerSpy, message: "message", qrScanningInteractor: qrScanningInteractor, verifyMessageInteractor: verifyMessageInteractor)

        return sut
    }
}

private class ViewControllerSpy: QRCodeScannerViewControllerProtocol {

    var showVideoViewCalled: Int = 0
    var askForCameraPermissionsCalled: Int = 0
    var stopScanningCalled: Int = 0
    var startScanningCalled: Int = 0
    var signatureValidCalled: Int = 0
    var signatureInvalidCalled: Int = 0
    
    func showVideoView() {
        
        showVideoViewCalled += 1
    }
    
    func askForCameraPermissions() {
        
        askForCameraPermissionsCalled += 1
    }
    
    func stopScanning() {
        
        stopScanningCalled += 1
    }
    
    func startScanning() {
        
        startScanningCalled += 1
    }
    
    func signatureValid() {
        
        signatureValidCalled += 1
    }
    
    func signatureInvalid() {
        
        signatureInvalidCalled += 1
    }
}

private class RouterSpy: QRCodeScannerRouterProtocol {
    
    var navigateBackCalled: Int = 0
    var navigateToSignatureDetailsCalled: Int = 0
    var navigateToAlertCalled: Int = 0
    
    func navigateBack() {
        
        navigateBackCalled += 1
    }
    
    func navigateToAlert(title: String, message: String, primaryAction: ((DialogAction) -> Void)?) {
        
        navigateToAlertCalled += 1
    }
}

private class MockQrScanningInteractor: QrScanningInteractorProtocol {
    
    var qrScaningFunction: (() -> Void)!

    func stubQrScanningFunctionFor(_ f: @autoclosure @escaping (() -> Void)) {
        self.qrScaningFunction = f
    }
    
    func processQrs(qrs: [String]) {
        
        qrScaningFunction()
    }
    
    func getCameraPermissionsStatus() {
        
        qrScaningFunction()
    }
}

private class MockVerifyMessageInteractor: VerifyMessageInteractorProtocol {
    
    var verifyMessageFunction: (() -> Void)!

    func stubVerifyMessageFor(_ f: @autoclosure @escaping (() -> Void)) {
        self.verifyMessageFunction = f
    }
    
    func verifyMessage(_ message: String, signature: String) {
        
        verifyMessageFunction()
    }
}
