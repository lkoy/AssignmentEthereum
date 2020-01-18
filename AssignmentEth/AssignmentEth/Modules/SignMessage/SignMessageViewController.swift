//
//  SignMessageViewController.swift
//  AssignmentEth
//
//  Created by ttg on 18/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import UIKit

final class SignMessageViewController: BaseViewController {
    
    override var prefersNavigationBarHidden: Bool { return true }

    var presenter: SignMessagePresenterProtocol!

    // MARK: - Component Declaration

    private enum ViewTraits {
        static let marginsTopBar = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 0)
        static let marginsButton = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        static let marginsField = UIEdgeInsets(top: 0, left: 15, bottom: 10, right: 15)
        static let spacing: CGFloat = 16.0
        static let buttonWidth: CGFloat = 160.0
        static let buttonHeight: CGFloat = 40.0
    }
    
    private var topBar: TopBarView!
    private var messageField: TextField!
    private var signButton: Button!
    
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

    // MARK: - Setup

    override func setupComponents() {

        view.backgroundColor = .white
        
        topBar = TopBarView(type: .navigation, title: "Signing")
        topBar.delegate = self
        topBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topBar)
        
        messageField = TextField()
        messageField.title = "Your message"
        messageField.status = .normal
        messageField.keyboardType = .default
        messageField.delegate = self
        messageField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(messageField)
        
        signButton = Button(style: .violet)
        signButton.title = "Sign message"
        signButton.addTarget(self, action: #selector(signMessageTapped), for: .touchUpInside)
        signButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(signButton)
    }

    override func setupConstraints() {

        bottomConstraint = signButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -ViewTraits.marginsButton.bottom)
        NSLayoutConstraint.activate([
            topBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: ViewTraits.marginsTopBar.top),
            topBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            messageField.topAnchor.constraint(equalTo: topBar.bottomAnchor, constant: ViewTraits.marginsTopBar.bottom),
            messageField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ViewTraits.marginsField.left),
            messageField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -ViewTraits.marginsField.right),
            
            signButton.widthAnchor.constraint(equalToConstant: ViewTraits.buttonWidth),
            signButton.heightAnchor.constraint(equalToConstant: ViewTraits.buttonHeight),
            signButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bottomConstraint
        ])
    }
    
    override func setupAccessibilityIdentifiers() {
        
    }

    // MARK: - Actions

    @objc private func signMessageTapped() {

        let message = messageField.value
        self.presenter.singMessage(message)
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

// MARK: - SignMessageViewControllerProtocol
extension SignMessageViewController: SignMessageViewControllerProtocol {
 
}

// MARK: - TopBar Delegate
extension SignMessageViewController: TopBarViewDelegate {
    
    func topBarView(_ topBarView: TopBarView, didPressItem item: Button) {
        presenter.backPressed()
    }
}

// MARK: - UITextFieldDelegate
extension SignMessageViewController: TextFieldDelegate {
     
    
}
