//
//  QrCameraPermissionInteractor.swift
//  AssignmentEth
//
//  Created by Iglesias, Gustavo on 18/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import Foundation

protocol QrScanningInteractorProtocol: BaseInteractorProtocol {
    func processQrs(qrs: [String])
    func getCameraPermissionsStatus()
}

protocol QrScanningInteractorCallbackProtocol: BaseInteractorCallbackProtocol {
    func foundQR(signature: String)
    func invalidQr()
    func notDeterminedCameraPermissions()
    func authorizedCameraPermissions()
    func disabledCameraPermissions()
}

class QrScanningInteractor: BaseInteractor {

    weak var presenter: QrScanningInteractorCallbackProtocol!
    
    private let qrMapperWorker: QrMapperWorkerAlias!
    private let camera: CameraPermissionStatus!
    
    init(worker: QrMapperWorkerAlias, camera: CameraPermissionStatus) {
        self.camera = camera
        self.qrMapperWorker = worker
        super.init()
    }
    
}

extension QrScanningInteractor: QrScanningInteractorProtocol {

    func processQrs(qrs: [String]) {
        qrMapperWorker.execute(input: qrs) { [weak self] (signature) in
            guard let self = self else { return }
            if signature.count > 0 {
                self.presenter.foundQR(signature: signature)
            } else {
                self.presenter.invalidQr()
            }
        }
    }
    
    func getCameraPermissionsStatus() {
        if camera.status == .denied {
            self.presenter.disabledCameraPermissions()
        } else if camera.status == .notDetermined {
            self.presenter.notDeterminedCameraPermissions()
        } else {
            self.presenter.authorizedCameraPermissions()
        }
    }
    
}
