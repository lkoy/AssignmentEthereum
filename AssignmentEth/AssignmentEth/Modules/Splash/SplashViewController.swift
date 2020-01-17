//
//  SplashViewController.swift
//  AssignmentMoneyou
//
//  Created by ttg on 22/09/2019.
//  Copyright © 2019 ttg. All rights reserved.
//

import UIKit
import Lottie
import EthereumKit

final class SplashViewController: BaseViewController {

    override var prefersNavigationBarHidden: Bool { return true }
    
    var presenter: SplashPresenterProtocol!
    
    // MARK: - Component Declaration
    
    private var animationView = LOTAnimationView(name: "loading-animation")
    
    private enum ViewTraits {
        static let margins = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        static let loadingsize: CGFloat = 80.0
    }

    // MARK: - ViewLife Cycle

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let datadir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]

        var error: NSError?

        let wallet = Wallet(network: .rinkeby, privateKey: "30278911D6B6E8FB4D53AF9F4EBAF8B8BEA8D6752CCB1FC316E4EC861D87AFD9", debugPrints: true)

        let dataKey = Data(hex: "30278911D6B6E8FB4D53AF9F4EBAF8B8BEA8D6752CCB1FC316E4EC861D87AFD9")

        let publicKey = Crypto.generatePublicKey(data: dataKey, compressed: false)
        print("Calculated Public key: \(publicKey.toHexString())")
        print("Wallet Public key: \(wallet.publicKey().toHexString())")
        let keccaked = Crypto.hashSHA3_256(publicKey.dropFirst()).suffix(20)

        let accountAddress = EIP55.encode(keccaked)
        print("Address Calculated: 0x\(accountAddress)")

        print("Address: \(wallet.address())" )
        let projectId = "0903bd90102540bb878e8d917778352a"
        let projectSecret = "85d17c3df66a407aa1c72f7dbe2641d1"
        let ribenkyNode = "rinkeby.infura.io/v3/0903bd90102540bb878e8d917778352a"
        let etherscanApiKey = "TBQWJE1Z1Q8U4IBMTGMFN4RADS79Z36N8U"
        
        let configuration = Configuration(
            network: .rinkeby,
            nodeEndpoint: "https://rinkeby.infura.io/v3/0903bd90102540bb878e8d917778352a",
            etherscanAPIKey: "TBQWJE1Z1Q8U4IBMTGMFN4RADS79Z36N8U",
            debugPrints: true
        )

        let geth = Geth(configuration: configuration)

        // To get a balance of an address, call `getBalance`.
        geth.getBalance(of: wallet.address(), blockParameter: .latest) { result in
            // Do something
            print("Result: \(result)")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        presenter.checkRegistrationStatus()
    }
    
    // MARK: - Setup

    override func setupComponents() {

        view.backgroundColor = .white
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.contentMode = .scaleAspectFit
        animationView.loopAnimation = true
        animationView.isUserInteractionEnabled = false
        view.addSubview(animationView)
        animationView.play()
    }

    override func setupConstraints() {
        
        NSLayoutConstraint.activate([
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            animationView.heightAnchor.constraint(equalToConstant: ViewTraits.loadingsize),
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.widthAnchor.constraint(equalToConstant: ViewTraits.loadingsize)
        ])
    }
    
    override func setupAccessibilityIdentifiers() {
        
    }

    // MARK: - Actions

    // MARK: Private Methods

}

// MARK: - SplashViewControllerProtocol
extension SplashViewController: SplashViewControllerProtocol {
 
}
