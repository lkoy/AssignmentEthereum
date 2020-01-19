//
//  QRCodeScannerPresenter.swift
//  AssignmentEth
//
//  Created by ttg on 18/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import Foundation

protocol QRCodeScannerViewControllerProtocol: BaseViewControllerProtocol {

    func showVideoView()
    func askForCameraPermissions()
    func stopScanning()
    func startScanning()
    func signatureValid()
    func signatureInvalid()
}

protocol QRCodeScannerPresenterProtocol: BasePresenterProtocol {

    func prepareView()
    func viewAppear()
    func readedQrs(_ qrs: [String])
    func backPressed()
}

final class QRCodeScannerPresenter<T: QRCodeScannerViewControllerProtocol, U: QRCodeScannerRouterProtocol>: BasePresenter<T, U> {

    private let messageToVerify: String
    private var qrScanningInteractor: QrScanningInteractorProtocol!
    private var verifyMessageInteractor: VerifyMessageInteractorProtocol!
    
    init(viewController: T, router: U, message: String, qrScanningInteractor: QrScanningInteractorProtocol, verifyMessageInteractor: VerifyMessageInteractorProtocol) {
        
        self.qrScanningInteractor = qrScanningInteractor
        self.verifyMessageInteractor = verifyMessageInteractor
        self.messageToVerify = message
        super.init(viewController: viewController, router: router)
    }
    
}

extension QRCodeScannerPresenter: QRCodeScannerPresenterProtocol {

    func prepareView() {
        
        qrScanningInteractor.getCameraPermissionsStatus()
    }
    
    func readedQrs(_ qrs: [String]) {
        viewController.stopScanning()
        qrScanningInteractor.processQrs(qrs: qrs)
    }
    
    func viewAppear() {
        viewController.startScanning()
    }
    
    func backPressed() {
        router.navigateBack()
    }
    
}

extension QRCodeScannerPresenter: QrScanningInteractorCallbackProtocol {
    
    func notDeterminedCameraPermissions() {
        viewController.askForCameraPermissions()
    }
    
    func authorizedCameraPermissions() {
        viewController.showVideoView()
    }
    
    func disabledCameraPermissions() {
//        router.showCameraPermissionsDenied(closeAction: nil)
    }
    
    func foundQR(signature: String) {
        
        self.verifyMessageInteractor.verifyMessage(self.messageToVerify, signature: signature)
    }
    
    func invalidQr() {
        viewController.stopScanning()
        }
}

extension QRCodeScannerPresenter: VerifyMessageInteractorCallbackProtocol {
    
    func messageVerified(valid: Bool) {
        
        if valid {
            self.viewController.signatureValid()
            self.router.navigateToAlert(title: "Result", message: "Signature valid", primaryAction: { [weak self] (_) in
                guard let self = self else { return }
                
                self.viewController.startScanning()
            })
        } else {
            self.viewController.signatureInvalid()
            self.router.navigateToAlert(title: "Result", message: "Signature invalid", primaryAction: { [weak self] (_) in
                guard let self = self else { return }
                
                self.viewController.startScanning()
            })
        }
    }
    
    func show(error: VerifyMessageInteractorError) {
        self.router.navigateToAlert(title: "Error", message: "Signature not well formed", primaryAction: { [weak self] (_) in
            guard let self = self else { return }
            
            self.viewController.startScanning()
        })
    }
}
