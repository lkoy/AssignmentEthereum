//
//  SignMessageInteractorTests.swift
//  AssignmentEthTests
//
//  Created by Iglesias, Gustavo on 20/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import XCTest
import Nimble
import EthereumKit

@testable import AssignmentEth

class SignMessageInteractorTests: XCTestCase {
    
    private var sut: SignMessageInteractor!
    private var presenter: SpyPresenter!
    private var mockSignMessageWorker: MockSignMessageWorker!
    private var privateKeyKeychain: CodableKeychain<AppModels.PrivateKeyApp> = PrivateKeyKeychainBuilder.build()

    override func setUp() {
        
        super.setUp()
        try? privateKeyKeychain.delete()
    }

    override func tearDown() {
        
        presenter = nil
        sut = nil
        try? privateKeyKeychain.delete()
        super.tearDown()
    }

    func test_no_private_key_on_keychain_then_show_fetch_error() {
        
//        try? privateKeyKeychain.store(codable: AppModels.PrivateKeyApp(pritateKey: "private_key"))
        givenSutWithMessageSignedResult(.success(AppModels.MessageSigned(message: "message", signedMessage: "message_signed")))
        
        sut.signMessage("message")
        expect(self.presenter.showErrorCalled).toEventually(equal(1))
        expect(self.presenter.showError).toEventually(equal(.fetchPrivateKeyError))
    }
    
    func test_private_key_on_keychain_message_signed_then_call_message_signed() {
            
        try? privateKeyKeychain.store(codable: AppModels.PrivateKeyApp(pritateKey: "private_key"))
        givenSutWithMessageSignedResult(.success(AppModels.MessageSigned(message: "message", signedMessage: "message_signed")))
            
        sut.signMessage("message")
        expect(self.presenter.messageSignedCalled).toEventually(equal(1))
    }
    
    func test_private_key_on_keychain_message_not_signed_then_show_fetch_error() {
            
        try? privateKeyKeychain.store(codable: AppModels.PrivateKeyApp(pritateKey: "private_key"))
        givenSutWithMessageSignedResult(.failure(.cryptoError(.failedToSign)))
            
        sut.signMessage("message")
        expect(self.presenter.showErrorCalled).toEventually(equal(1))
        expect(self.presenter.showError).toEventually(equal(.signMessageError))
    }
    
    private func givenSutWithMessageSignedResult(_ message: Result<AppModels.MessageSigned>) {
        
        presenter = SpyPresenter()
        mockSignMessageWorker = MockSignMessageWorker(result: message)
        
        sut = SignMessageInteractor(withSignMessageWorker: mockSignMessageWorker, keyChain: privateKeyKeychain)

        sut.presenter = presenter
    }
}

private class SpyPresenter: SignMessageInteractorCallbackProtocol {
    
    var messageSignedCalled: Int = 0
    var showErrorCalled: Int = 0
    
    var showError: SignMessageInteractorError?
    
    func messageSigned(_ messageSigned: AppModels.MessageSigned) {
        
        messageSignedCalled += 1
    }
    
    func show(error: SignMessageInteractorError) {
        
        showErrorCalled += 1
        showError = error
    }
}

private class MockSignMessageWorker: SignMessageWorkerAlias {
    
    var result: Result<AppModels.MessageSigned>
    
    init(result: Result<AppModels.MessageSigned>) {
        self.result = result
    }
    
    override func job(input: SignMessageParameters, completion: @escaping ((Result<AppModels.MessageSigned>) -> Void)) {
        completion(result)
    }
}
