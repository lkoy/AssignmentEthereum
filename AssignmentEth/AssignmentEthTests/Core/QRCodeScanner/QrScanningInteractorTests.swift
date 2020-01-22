//
//  QrScanningInteractorTests.swift
//  AssignmentEthTests
//
//  Created by Iglesias, Gustavo on 20/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import XCTest
import Nimble

@testable import AssignmentEth

class QrScanningInteractorTests: XCTestCase {

    private var sut: QrScanningInteractor!
    private var spyPresenter: SpyPresenter!
    private var mockCameraPermisions: MockCameraPermissionStatus!
    
    override func setUp() {
        
        super.setUp()
        mockCameraPermisions = MockCameraPermissionStatus()
        sut = QrScanningInteractor(worker: QrMapperWorker(), camera: mockCameraPermisions)
        spyPresenter = SpyPresenter()
        sut.presenter = spyPresenter
    }

    override func tearDown() {
        
        sut = nil
        spyPresenter = nil
        mockCameraPermisions = nil
        super.tearDown()
    }

    func test_get_camera_persimions_not_determined_then_call_not_determined() {
        
        mockCameraPermisions.stubStatus = .notDetermined
        sut.getCameraPermissionsStatus()
        
        expect(self.spyPresenter.qrCalled).toEventually(equal(0))
        expect(self.spyPresenter.invalidQrCalled).toEventually(equal(0))
        expect(self.spyPresenter.result).toEventually(beNil())
        expect(self.spyPresenter.notDeterminedCameraPermissionsCalled).toEventually(equal(1))
        expect(self.spyPresenter.authorizedCameraPermissionsCalled).toEventually(equal(0))
        expect(self.spyPresenter.disabledCameraPermissionsCalled).toEventually(equal(0))
    }
    
    func test_get_camera_persimions_authorised_then_call_authorised() {
        
        mockCameraPermisions.stubStatus = .authorized
        sut.getCameraPermissionsStatus()
        
        expect(self.spyPresenter.qrCalled).toEventually(equal(0))
        expect(self.spyPresenter.invalidQrCalled).toEventually(equal(0))
        expect(self.spyPresenter.result).toEventually(beNil())
        expect(self.spyPresenter.notDeterminedCameraPermissionsCalled).toEventually(equal(0))
        expect(self.spyPresenter.authorizedCameraPermissionsCalled).toEventually(equal(1))
        expect(self.spyPresenter.disabledCameraPermissionsCalled).toEventually(equal(0))
    }
    
    func test_get_camera_persimions_disabled_then_call_disable_camera() {
        
        mockCameraPermisions.stubStatus = .denied
        sut.getCameraPermissionsStatus()
        
        expect(self.spyPresenter.qrCalled).toEventually(equal(0))
        expect(self.spyPresenter.invalidQrCalled).toEventually(equal(0))
        expect(self.spyPresenter.result).toEventually(beNil())
        expect(self.spyPresenter.notDeterminedCameraPermissionsCalled).toEventually(equal(0))
        expect(self.spyPresenter.authorizedCameraPermissionsCalled).toEventually(equal(0))
        expect(self.spyPresenter.disabledCameraPermissionsCalled).toEventually(equal(1))
    }
    
    func test_process_not_valid_qr() {
        let invalidQr = [""]
        
        sut.processQrs(qrs: invalidQr)
        
        expect(self.spyPresenter.qrCalled).toEventually(equal(0))
        expect(self.spyPresenter.invalidQrCalled).toEventually(equal(1))
        expect(self.spyPresenter.result).toEventually(beNil())
    }
    
    func test_process_valid_qr() {
        let validQr = ["hwegogojlsjdgojds"]
        
        sut.processQrs(qrs: validQr)
        
        expect(self.spyPresenter.qrCalled).toEventually(equal(1))
        expect(self.spyPresenter.invalidQrCalled).toEventually(equal(0))
        expect(self.spyPresenter.result).toEventually(equal("hwegogojlsjdgojds"))
    }
}

private class SpyPresenter: QrScanningInteractorCallbackProtocol {
    
    var qrCalled: Int = 0
    var invalidQrCalled: Int = 0
    var notDeterminedCameraPermissionsCalled: Int = 0
    var authorizedCameraPermissionsCalled: Int = 0
    var disabledCameraPermissionsCalled: Int = 0
    
    var result: String?
    
    func foundQR(signature: String) {
        
        qrCalled += 1
        self.result = signature
    }
    
    func invalidQr() {
        
        invalidQrCalled += 1
    }
    
    func notDeterminedCameraPermissions() {
        
        notDeterminedCameraPermissionsCalled += 1
    }
    
    func authorizedCameraPermissions() {
        
        authorizedCameraPermissionsCalled += 1
    }
    
    func disabledCameraPermissions() {
        
        disabledCameraPermissionsCalled += 1
    }
}
