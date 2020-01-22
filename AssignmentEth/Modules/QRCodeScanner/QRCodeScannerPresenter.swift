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
    
    func verifyMessageWithSignature(_ signature: String) {
        
        self.verifyMessageInteractor.verifyMessage(self.messageToVerify, signature: signature)
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
        
        self.router.navigateToAlert(title: NSLocalizedString("error_alert_title", comment: "Error alert title"),
                                    message: NSLocalizedString("error_disabled_camera_message", comment: "Camera disabled"),
                                    primaryAction: nil)
    }
    
    func foundQR(signature: String) {
        
        self.verifyMessageWithSignature(signature)
    }
    
    func invalidQr() {
        
        self.router.navigateToAlert(title: NSLocalizedString("error_alert_title", comment: "Error alert title"),
                                    message: NSLocalizedString("error_invalid_qr_message", comment: "QR not valid format"),
                                    primaryAction: { [weak self] (_) in
            guard let self = self else { return }
            
            self.viewController.startScanning()
        })
    }
}

extension QRCodeScannerPresenter: VerifyMessageInteractorCallbackProtocol {
    
    func messageVerified(valid: Bool) {
        
        let title = NSLocalizedString("validation_alert_title", comment: "Validation alert title")
        var message = NSLocalizedString("validation_valid_mesage", comment: "Validation alert message valid")
        if valid {
            self.viewController.signatureValid()
        } else {
            self.viewController.signatureInvalid()
            message = NSLocalizedString("validation_invalide_mesage", comment: "Validation alert message invalid")
        }
        
        self.router.navigateToAlert(title: title, message: message, primaryAction: { [weak self] (_) in
            guard let self = self else { return }
            
            self.viewController.startScanning()
        })
    }
    
    func show(error: VerifyMessageInteractorError) {
        
        self.router.navigateToAlert(title: NSLocalizedString("error_alert_title", comment: "Error alert title"),
                                    message: NSLocalizedString("error_signature_message", comment: "Error signature message"),
                                    primaryAction: { [weak self] (_) in
                                        guard let self = self else { return }
            
                                        self.viewController.startScanning()
                                    })
    }
}
