//
//  VerifyMessageInteractorTests.swift
//  AssignmentEthTests
//
//  Created by Iglesias, Gustavo on 22/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import XCTest
import Nimble

@testable import AssignmentEth

class VerifyMessageInteractorTests: XCTestCase {
    
    private var sut: VerifyMessageInteractor!
    private var spyPresenter: SpyPresenter!
    private var privateKeyKeychain: CodableKeychain<AppModels.PrivateKeyApp> = PrivateKeyKeychainBuilder.build()

    override func setUp() {
        
        super.setUp()
        sut = VerifyMessageInteractor()
        spyPresenter = SpyPresenter()
        sut.presenter = spyPresenter
        try? privateKeyKeychain.delete()
    }

    override func tearDown() {
        
        sut = nil
        spyPresenter = nil
        try? privateKeyKeychain.delete()
        super.tearDown()
    }
    
    func test_no_private_key_on_keychain_then_show_fetch_error() {
            
    //        try? privateKeyKeychain.store(codable: AppModels.PrivateKeyApp(pritateKey: "private_key"))
        let message = "message"
        let invalidSignature = ""
        
        sut.verifyMessage(message, signature: invalidSignature)
            
        expect(self.spyPresenter.showCalled).toEventually(equal(1))
        expect(self.spyPresenter.messageVerifiedCalled).toEventually(equal(0))
        expect(self.spyPresenter.resultError).toEventually(equal(.fetchPrivateKeyError))
    }
    
    func test_process_empty_signature() {
        
        try? privateKeyKeychain.store(codable: AppModels.PrivateKeyApp(pritateKey: "private_key"))
        let message = "message"
        let invalidSignature = ""
        
        sut.verifyMessage(message, signature: invalidSignature)
        
        expect(self.spyPresenter.showCalled).toEventually(equal(0))
        expect(self.spyPresenter.messageVerifiedCalled).toEventually(equal(1))
        expect(self.spyPresenter.resultError).toEventually(beNil())
        expect(self.spyPresenter.resultMessageVerified).toEventually(equal(false))
    }
}

private class SpyPresenter: VerifyMessageInteractorCallbackProtocol {
    
    var messageVerifiedCalled: Int = 0
    var showCalled: Int = 0
    
    var resultMessageVerified: Bool?
    var resultError: VerifyMessageInteractorError?
    
    func messageVerified(valid: Bool) {
        
        messageVerifiedCalled += 1
        self.resultMessageVerified = valid
    }
    
    func show(error: VerifyMessageInteractorError) {
        
        showCalled += 1
        self.resultError = error
    }
}
