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
    
    init(viewController: T, router: U, message: String, qrScanningInteractor: QrScanningInteractorProtocol) {
        
        self.qrScanningInteractor = qrScanningInteractor
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
//        interactor.processQrs(qrs: qrs)
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
        
//        router.navigateToCompletion()
    }
    
    func invalidQr() {
        viewController.stopScanning()
        }
}
