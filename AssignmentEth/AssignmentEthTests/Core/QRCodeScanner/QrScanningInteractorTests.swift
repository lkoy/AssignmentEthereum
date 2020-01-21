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
    
    override func setUp() {
        
        super.setUp()
        sut = QrScanningInteractor(worker: QrMapperWorker(), camera: MockCameraPermissionStatus())
        spyPresenter = SpyPresenter()
        sut.presenter = spyPresenter
    }

    override func tearDown() {
        
        sut = nil
        spyPresenter = nil
        super.tearDown()
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
    
    var result: String?
    
    func foundQR(signature: String) {
        
        qrCalled += 1
        self.result = signature
    }
    
    func invalidQr() {
        
        invalidQrCalled += 1
    }
    
    func notDeterminedCameraPermissions() {
        
        //Not implemented, not needed in tests
    }
    
    func authorizedCameraPermissions() {
        
        //Not implemented, not needed in tests
    }
    
    func disabledCameraPermissions() {
        
        //Not implemented, not needed in tests
    }
}
