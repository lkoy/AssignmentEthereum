//
//  SetupAccountInteractorTests.swift
//  AssignmentEthTests
//
//  Created by Iglesias, Gustavo on 20/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import XCTest
import Nimble
import EthereumKit

@testable import AssignmentEth

class SetupAccountInteractorTests: XCTestCase {
    
    private var sut: SetupAccountInteractor!
    private var presenter: SpyPresenter!
    private var mockSetupAccountWorker: MockSetupAccountWorker!
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
    
    func test_given_get_accounts_responds_success() {
        
        givenSutWithAccount(.success(AppModels.AccountDetails(address: "address", ether: 0)))
        sut.getAccountDetails(forPrivateKey: "1234")
        
        expect(self.presenter.accoutObtainedCalled).toEventually(equal(1))
        expect(try? self.privateKeyKeychain.fetch()).toEventually(equal(AppModels.PrivateKeyApp(pritateKey: "1234")))
    }
    
    func test_given_get_accounts_responds_failure() {
        
        givenSutWithAccount(.failure(.contractError(.containsInvalidCharactor(0))))
        sut.getAccountDetails(forPrivateKey: "1234")
        
        expect(self.presenter.showErrorCalled).toEventually(equal(1))
        expect(try? self.privateKeyKeychain.fetch()).toEventually(beNil())
    }

    private func givenSutWithAccount(_ account: Result<AppModels.AccountDetails>) {
        
        presenter = SpyPresenter()
        mockSetupAccountWorker = MockSetupAccountWorker(result: account)
        
        sut = SetupAccountInteractor(withSetupAccountWorker: mockSetupAccountWorker)

        sut.presenter = presenter
    }
}

private class SpyPresenter: SetupAccountInteractorCallbackProtocol {
    
    var accoutObtainedCalled: Int = 0
    var showErrorCalled: Int = 0
    
    var showError: SetupAccountInteractorError?
    
    func accoutObtained(accountDetails: AppModels.AccountDetails) {
        
        accoutObtainedCalled += 1
    }
    
    func showError(_ error: SetupAccountInteractorError) {
        
        showErrorCalled += 1
        showError = error
    }
}

private class MockSetupAccountWorker: SetupAccountWorkerAlias {
    
    var result: Result<AppModels.AccountDetails>
    
    init(result: Result<AppModels.AccountDetails>) {
        self.result = result
    }
    
    override func job(input: String, completion: @escaping ((Result<AppModels.AccountDetails>) -> Void)) {
        completion(result)
    }
}
