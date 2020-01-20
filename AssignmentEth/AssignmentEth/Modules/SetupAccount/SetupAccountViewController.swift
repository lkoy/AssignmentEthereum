//
//  SetupAccountViewController.swift
//  AssignmentEth
//
//  Created by ttg on 17/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import UIKit

final class SetupAccountViewController: BaseViewController {

    override var prefersNavigationBarHidden: Bool { return true }
    
    var presenter: SetupAccountPresenterProtocol!

    // MARK: - Component Declaration

    private enum ViewTraits {
        static let marginsTopBar = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 0)
        static let marginsButton = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        static let marginsField = UIEdgeInsets(top: 0, left: 15, bottom: 10, right: 15)
        static let spacing: CGFloat = 16.0
        static let buttonWidth: CGFloat = 120.0
    }
    
    private var topBar: TopBarView!
    private var privateKeyField: TextField!
    private var confirmButton: Button!
    
    private var bottomConstraint: NSLayoutConstraint!
    
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
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyBoardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyBoardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showKeyboard()
    }

    // MARK: - Setup

    override func setupComponents() {

        view.backgroundColor = .white
        
        topBar = TopBarView(type: .title,
                            title: NSLocalizedString("setup_title", comment: "Setup screen title"),
                            subtitle: NSLocalizedString("setup_subtitle", comment: "Setup screen subtitle"))
        topBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topBar)
        
        privateKeyField = TextField()
        privateKeyField.title = "Private key"
        privateKeyField.status = .normal
        privateKeyField.keyboardType = .default
        privateKeyField.returnKeyType = .done
        privateKeyField.delegate = self
        privateKeyField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(privateKeyField)
        
        confirmButton = Button(style: .blue)
        confirmButton.title = NSLocalizedString("continue_button", comment: "Continue button")
        confirmButton.addTarget(self, action: #selector(confirmTapped), for: .touchUpInside)
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(confirmButton)
    }

    override func setupConstraints() {

        bottomConstraint = confirmButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -ViewTraits.marginsButton.bottom)
        NSLayoutConstraint.activate([
            topBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: ViewTraits.marginsTopBar.top),
            topBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            privateKeyField.topAnchor.constraint(equalTo: topBar.bottomAnchor, constant: ViewTraits.marginsTopBar.bottom),
            privateKeyField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ViewTraits.marginsField.left),
            privateKeyField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -ViewTraits.marginsField.right),
            
            confirmButton.widthAnchor.constraint(equalToConstant: ViewTraits.buttonWidth),
            confirmButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bottomConstraint
        ])
    }
    
    override func setupAccessibilityIdentifiers() {
        
    }

    // MARK: - Actions
    
    @objc private func confirmTapped() {
        "30278911D6B6E8FB4D53AF9F4EBAF8B8BEA8D6752CCB1FC316E4EC861D87AFD9"
        let privateKey = privateKeyField.value
        self.presenter.getDetails(forInput: privateKey)
    }

    // MARK: Private Methods

    @objc private func keyBoardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
            animateButton(duration: duration, offset: -(ViewTraits.spacing + keyboardSize.height))
        }
    }
    
    @objc private func keyBoardWillHide(notification: NSNotification) {
        if let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
            animateButton(duration: duration, offset: -ViewTraits.marginsButton.bottom)
        }
    }
    
    private func animateButton(duration: Double, offset: CGFloat) {
        bottomConstraint.constant = offset
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseIn, animations: {
            self.view.layoutSubviews()
        }, completion: nil)
    }
}

// MARK: - SetupAccountViewControllerProtocol
extension SetupAccountViewController: SetupAccountViewControllerProtocol {
 
    func showKeyboard() {
//        privateKeyField.becomeFirstResponder()
    }
    
    func showLoadingState() {
        confirmButton.isLoading = true
    }
    
    func hideLoadingState() {
        confirmButton.isLoading = false
    }
}

// MARK: - UITextFieldDelegate
extension SetupAccountViewController: TextFieldDelegate {
     
    func textFieldDidPressReturnKey(_ textField: TextField) {
        self.presenter.getDetails(forInput:textField.value)
    }
}
