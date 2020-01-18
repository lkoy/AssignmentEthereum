//
//  AccountDetailsViewController.swift
//  AssignmentEth
//
//  Created by ttg on 18/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import UIKit

final class AccountDetailsViewController: BaseViewController {

    override var prefersNavigationBarHidden: Bool { return true }
    
    var presenter: AccountDetailsPresenterProtocol!

    // MARK: - Component Declaration

    private enum ViewTraits {
        static let marginsTopBar = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 0)
        static let margins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        static let marginsButton = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        static let buttonHeight: CGFloat = 40.0
    }
    
    private var topBar: TopBarView!
    private var signButton: Button!
    private var verifyButton: Button!
    
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
        
        topBar = TopBarView(type: .title, title: "Account")
        topBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topBar)
        
        signButton = Button(style: .green)
        signButton.title = "Sign"
        signButton.addTarget(self, action: #selector(signTapped), for: .touchUpInside)
        signButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(signButton)
        
        verifyButton = Button(style: .green)
        verifyButton.title = "Continue"
        verifyButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        verifyButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(verifyButton)
    }

    override func setupConstraints() {

        NSLayoutConstraint.activate([
            topBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: ViewTraits.marginsTopBar.top),
            topBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            signButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ViewTraits.marginsButton.left),
            signButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -ViewTraits.marginsButton.right),
            signButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ViewTraits.marginsButton.left),
            signButton.heightAnchor.constraint(equalToConstant: ViewTraits.buttonHeight),
            
            verifyButton.topAnchor.constraint(equalTo: signButton.bottomAnchor, constant: ViewTraits.marginsButton.top),
            verifyButton.heightAnchor.constraint(equalToConstant: ViewTraits.buttonHeight),
            verifyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -ViewTraits.marginsButton.right),
            verifyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ViewTraits.marginsButton.left),
            verifyButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -ViewTraits.marginsButton.bottom),
        ])
    }
    
    override func setupAccessibilityIdentifiers() {
        
    }

    // MARK: - Actions
    
    @objc private func signTapped() {
        
//        self.presenter.getDetails(forInput: privateKey)
    }
    
    @objc private func continueTapped() {
        
//        self.presenter.getDetails(forInput: privateKey)
    }

    // MARK: Private Methods

}

// MARK: - AccountDetailsViewControllerProtocol
extension AccountDetailsViewController: AccountDetailsViewControllerProtocol {
 
}
