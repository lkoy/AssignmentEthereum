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
        static let marginsBanner = UIEdgeInsets(top: 0, left: 15, bottom: 15, right: 15)
        static let titleMargins = UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
        static let subtitleMargins = UIEdgeInsets(top: 8, left: 16, bottom: 16, right: 16)
        static let cornerRadius: CGFloat = 4
    }
    
    private var topBar: TopBarView!
    private let contentView = UIView()
    private let textContainer = UIView()
    private let titleAddressLabel = Label(style: .title2)
    private let subtitleAddressLabel = Label(style: .subtitle1)
    private let titleBalanceLabel = Label(style: .title2)
    private let subtitleBalanceLabel = Label(style: .subtitle1)
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
    
    override func viewDidLoad() {
            super.viewDidLoad()
            presenter.prepareView()
        }

    // MARK: - Setup

    override func setupComponents() {

        view.backgroundColor = .white
        
        topBar = TopBarView(type: .title, title: "Account")
        topBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topBar)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = ViewTraits.cornerRadius
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.appViolet.cgColor
        view.addSubview(contentView)
        
        textContainer.translatesAutoresizingMaskIntoConstraints = false
        textContainer.backgroundColor = .clear
        textContainer.setContentHuggingPriority(.required, for: .vertical)
        textContainer.setContentCompressionResistancePriority(.required, for: .vertical)
        contentView.addSubview(textContainer)
        
        titleAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        titleAddressLabel.text = "Address"
        titleAddressLabel.backgroundColor = .clear
        titleAddressLabel.numberOfLines = 1
        titleAddressLabel.setContentHuggingPriority(.required, for: .vertical)
        titleAddressLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        textContainer.addSubview(titleAddressLabel)
        
        subtitleAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleAddressLabel.backgroundColor = .clear
        subtitleAddressLabel.numberOfLines = 1
        subtitleAddressLabel.setContentHuggingPriority(.required, for: .vertical)
        subtitleAddressLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        textContainer.addSubview(subtitleAddressLabel)
        
        titleBalanceLabel.translatesAutoresizingMaskIntoConstraints = false
        titleBalanceLabel.text = "Balance"
        titleBalanceLabel.backgroundColor = .clear
        titleBalanceLabel.numberOfLines = 1
        titleBalanceLabel.setContentHuggingPriority(.required, for: .vertical)
        titleBalanceLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        textContainer.addSubview(titleBalanceLabel)
        
        subtitleBalanceLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleBalanceLabel.backgroundColor = .clear
        subtitleAddressLabel.numberOfLines = 1
        subtitleBalanceLabel.setContentHuggingPriority(.required, for: .vertical)
        subtitleBalanceLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        textContainer.addSubview(subtitleBalanceLabel)
        
        signButton = Button(style: .violet)
        signButton.title = "Sign"
        signButton.addTarget(self, action: #selector(signTapped), for: .touchUpInside)
        signButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(signButton)
        
        verifyButton = Button(style: .violet)
        verifyButton.title = "Verify"
        verifyButton.addTarget(self, action: #selector(verificationTapped), for: .touchUpInside)
        verifyButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(verifyButton)
    }

    override func setupConstraints() {

        NSLayoutConstraint.activate([
            topBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: ViewTraits.marginsTopBar.top),
            topBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ViewTraits.marginsBanner.left),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -ViewTraits.marginsBanner.right),
            contentView.topAnchor.constraint(equalTo: topBar.bottomAnchor, constant: ViewTraits.marginsBanner.top),
            
            textContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            textContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            textContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            titleAddressLabel.leadingAnchor.constraint(equalTo: textContainer.leadingAnchor, constant: ViewTraits.titleMargins.left),
            titleAddressLabel.trailingAnchor.constraint(equalTo: textContainer.trailingAnchor, constant: -ViewTraits.titleMargins.right),
            titleAddressLabel.topAnchor.constraint(equalTo: textContainer.topAnchor, constant: ViewTraits.titleMargins.top),
            titleAddressLabel.bottomAnchor.constraint(equalTo: subtitleAddressLabel.topAnchor, constant: ViewTraits.titleMargins.bottom),
            
            subtitleAddressLabel.leadingAnchor.constraint(equalTo: textContainer.leadingAnchor, constant: ViewTraits.subtitleMargins.left),
            subtitleAddressLabel.trailingAnchor.constraint(equalTo: textContainer.trailingAnchor, constant: -ViewTraits.subtitleMargins.right),
            subtitleAddressLabel.bottomAnchor.constraint(equalTo: titleBalanceLabel.topAnchor, constant: -ViewTraits.subtitleMargins.bottom),
            
            titleBalanceLabel.leadingAnchor.constraint(equalTo: textContainer.leadingAnchor, constant: ViewTraits.titleMargins.left),
            titleBalanceLabel.trailingAnchor.constraint(equalTo: textContainer.trailingAnchor, constant: -ViewTraits.titleMargins.right),
            titleBalanceLabel.bottomAnchor.constraint(equalTo: subtitleBalanceLabel.topAnchor, constant: ViewTraits.titleMargins.bottom),
            
            subtitleBalanceLabel.leadingAnchor.constraint(equalTo: textContainer.leadingAnchor, constant: ViewTraits.subtitleMargins.left),
            subtitleBalanceLabel.trailingAnchor.constraint(equalTo: textContainer.trailingAnchor, constant: -ViewTraits.subtitleMargins.right),
            subtitleBalanceLabel.bottomAnchor.constraint(equalTo: textContainer.bottomAnchor, constant: -ViewTraits.subtitleMargins.bottom),
            
            signButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ViewTraits.marginsButton.left),
            signButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -ViewTraits.marginsButton.right),
            
            verifyButton.topAnchor.constraint(equalTo: signButton.bottomAnchor, constant: ViewTraits.marginsButton.top),
            verifyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -ViewTraits.marginsButton.right),
            verifyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ViewTraits.marginsButton.left),
            verifyButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -ViewTraits.marginsButton.bottom),
        ])
    }
    
    override func setupAccessibilityIdentifiers() {
        
    }

    // MARK: - Actions
    
    @objc private func signTapped() {
        
        self.presenter.continueToSign()
    }
    
    @objc private func verificationTapped() {
        
        self.presenter.continueToVerification()
    }

    // MARK: Private Methods

}

// MARK: - AccountDetailsViewControllerProtocol
extension AccountDetailsViewController: AccountDetailsViewControllerProtocol {
 
    func showAccountDetails(viewModel: AccountDetails.ViewModel){
        
        self.subtitleAddressLabel.text = viewModel.addressValue
        self.subtitleBalanceLabel.text = viewModel.balanceValue
    }
}
