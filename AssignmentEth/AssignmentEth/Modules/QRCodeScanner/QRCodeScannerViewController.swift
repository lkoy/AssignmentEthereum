//
//  QRCodeScannerViewController.swift
//  AssignmentEth
//
//  Created by ttg on 18/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import UIKit

final class QRCodeScannerViewController: BaseViewController {

    override var prefersNavigationBarHidden: Bool { return true }
    
    var presenter: QRCodeScannerPresenterProtocol!

    // MARK: - Component Declaration

    private enum ViewTraits {
        static let marginsTopBar = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 0)
    }
    
    private var topBar: TopBarView!
    
    public enum AccessibilityIds {
        
    }

    // MARK: - ViewLife Cycle
    /*
     Order:
     - viewDidLoad
     - viewWillAppear
     - viewDidAppear
     - viewWillDisapear
     - viewDidDisappear
     - viewWillLayoutSubviews
     - viewDidLayoutSubviews
     */

    // MARK: - Setup

    override func setupComponents() {

        view.backgroundColor = .white
        
        topBar = TopBarView(type: .navigation, title: "QR code scanner")
        topBar.delegate = self
        topBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topBar)
    }

    override func setupConstraints() {

        NSLayoutConstraint.activate([
            topBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: ViewTraits.marginsTopBar.top),
            topBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    override func setupAccessibilityIdentifiers() {
        
    }

    // MARK: - Actions

    // MARK: Private Methods

}

// MARK: - QRCodeScannerViewControllerProtocol
extension QRCodeScannerViewController: QRCodeScannerViewControllerProtocol {
 
}

// MARK: - TopBar Delegate
extension QRCodeScannerViewController: TopBarViewDelegate {
    
    func topBarView(_ topBarView: TopBarView, didPressItem item: Button) {
        presenter.backPressed()
    }
}
