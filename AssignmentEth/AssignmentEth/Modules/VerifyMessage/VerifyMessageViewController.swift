//
//  VerifyMessageViewController.swift
//  AssignmentEth
//
//  Created by ttg on 18/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import UIKit

final class VerifyMessageViewController: BaseViewController {

    override var prefersNavigationBarHidden: Bool { return true }
    
    var presenter: VerifyMessagePresenterProtocol!

    // MARK: - Component Declaration

    private enum ViewTraits {
        static let marginsButton = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        static let marginsField = UIEdgeInsets(top: 0, left: 15, bottom: 10, right: 15)
        static let spacing: CGFloat = 16.0
        static let buttonWidth: CGFloat = 160.0
        static let marginsTopBar = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 0)
    }
    
    private var topBar: TopBarView!
    private var messageField: TextField!
    private var verifyButton: Button!
    
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
        
        topBar = TopBarView(type: .navigation, title: NSLocalizedString("verify_message_title", comment: "Verification message screen title"))
        topBar.delegate = self
        topBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topBar)
        
        messageField = TextField()
        messageField.title = NSLocalizedString("your_message_label", comment: "Your message label text")
        messageField.status = .normal
        messageField.keyboardType = .default
        messageField.delegate = self
        messageField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(messageField)
        
        verifyButton = Button(style: .blue)
        verifyButton.title = NSLocalizedString("verify_message_button", comment: "Verify message button text")
        verifyButton.addTarget(self, action: #selector(verifyMessageTapped), for: .touchUpInside)
        verifyButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(verifyButton)
    }

    override func setupConstraints() {

        bottomConstraint = verifyButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -ViewTraits.marginsButton.bottom)
        NSLayoutConstraint.activate([
            topBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: ViewTraits.marginsTopBar.top),
            topBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            messageField.topAnchor.constraint(equalTo: topBar.bottomAnchor, constant: ViewTraits.marginsTopBar.bottom),
            messageField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ViewTraits.marginsField.left),
            messageField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -ViewTraits.marginsField.right),
            
            verifyButton.widthAnchor.constraint(equalToConstant: ViewTraits.buttonWidth),
            verifyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bottomConstraint
        ])
    }
    
    override func setupAccessibilityIdentifiers() {
        
    }

    // MARK: - Actions
    
    @objc private func verifyMessageTapped() {

        let message = messageField.value
        self.presenter.verifyMessage(message)
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

// MARK: - VerifyMessageViewControllerProtocol
extension VerifyMessageViewController: VerifyMessageViewControllerProtocol {
 
}

// MARK: - TopBar Delegate
extension VerifyMessageViewController: TopBarViewDelegate {
    
    func topBarView(_ topBarView: TopBarView, didPressItem item: Button) {
        presenter.backPressed()
    }
}

// MARK: - UITextFieldDelegate
extension VerifyMessageViewController: TextFieldDelegate {
     
    
}
