//
//  SignatureDetailsViewController.swift
//  AssignmentEth
//
//  Created by ttg on 18/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import UIKit

final class SignatureDetailsViewController: BaseViewController {
    
    override var prefersNavigationBarHidden: Bool { return true }

    var presenter: SignatureDetailsPresenterProtocol!

    var userBrightness: CGFloat?
    
    // MARK: - Component Declaration

    private enum ViewTraits {
        static let marginsTopBar = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 0)
        static let titleMargins = UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
        static let subtitleMargins = UIEdgeInsets(top: 8, left: 16, bottom: 16, right: 16)
        static let marginsBanner = UIEdgeInsets(top: 0, left: 15, bottom: 15, right: 15)
        static let marginsQrCode = UIEdgeInsets(top: 60, left: 0, bottom: 15, right: 0)
        static let qrCodeSize: CGFloat = 200.0
        static let cornerRadius: CGFloat = 4
    }
    
    private var topBar: TopBarView!
    private let contentView = UIView()
    private let textContainer = UIView()
    private let titleMessageLabel = Label(style: .title2)
    private let subtitleMessageLabel = Label(style: .subtitle1)
    private var qrCodeImage: UIImageView!
    
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
        startHandleScreenBrightness()
        self.presenter.prepareView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        backToUserBrightness()
    }
    
    // MARK: - Setup

    override func setupComponents() {

        view.backgroundColor = .white
        
        topBar = TopBarView(type: .navigation, title: "Signature")
        topBar.delegate = self
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
        
        titleMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        titleMessageLabel.text = "Message"
        titleMessageLabel.backgroundColor = .clear
        titleMessageLabel.numberOfLines = 1
        titleMessageLabel.setContentHuggingPriority(.required, for: .vertical)
        titleMessageLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        textContainer.addSubview(titleMessageLabel)
        
        subtitleMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleMessageLabel.backgroundColor = .clear
        subtitleMessageLabel.numberOfLines = 1
        subtitleMessageLabel.setContentHuggingPriority(.required, for: .vertical)
        subtitleMessageLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        textContainer.addSubview(subtitleMessageLabel)
        
        qrCodeImage = UIImageView()
        qrCodeImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(qrCodeImage)
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
            
            titleMessageLabel.leadingAnchor.constraint(equalTo: textContainer.leadingAnchor, constant: ViewTraits.titleMargins.left),
            titleMessageLabel.trailingAnchor.constraint(equalTo: textContainer.trailingAnchor, constant: -ViewTraits.titleMargins.right),
            titleMessageLabel.topAnchor.constraint(equalTo: textContainer.topAnchor, constant: ViewTraits.titleMargins.top),
            titleMessageLabel.bottomAnchor.constraint(equalTo: subtitleMessageLabel.topAnchor, constant: ViewTraits.titleMargins.bottom),
            
            subtitleMessageLabel.leadingAnchor.constraint(equalTo: textContainer.leadingAnchor, constant: ViewTraits.subtitleMargins.left),
            subtitleMessageLabel.trailingAnchor.constraint(equalTo: textContainer.trailingAnchor, constant: -ViewTraits.subtitleMargins.right),
            subtitleMessageLabel.bottomAnchor.constraint(equalTo: textContainer.bottomAnchor, constant: -ViewTraits.subtitleMargins.bottom),
            
            qrCodeImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            qrCodeImage.topAnchor.constraint(equalTo: textContainer.bottomAnchor, constant: ViewTraits.marginsQrCode.top),
            qrCodeImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -ViewTraits.marginsQrCode.bottom),
            qrCodeImage.widthAnchor.constraint(equalToConstant: ViewTraits.qrCodeSize),
            qrCodeImage.heightAnchor.constraint(equalToConstant: ViewTraits.qrCodeSize),
        ])
    }
    
    override func setupAccessibilityIdentifiers() {
        
    }

    // MARK: - Actions

    // MARK: Private Methods

    // MARK: - ScreenBrightnes
       func startHandleScreenBrightness() {
            userBrightness = UIScreen.main.brightness
            NotificationCenter.default.addObserver(self, selector: #selector(viewGoToBackground), name: UIApplication.willResignActiveNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(comesFromBackground), name: UIApplication.didBecomeActiveNotification, object: nil)
       }
       
       func backToUserBrightness() {
           guard let brightness = userBrightness  else {
                return
           }
           UIScreen.main.brightness = brightness
           userBrightness = nil
       }
       
       func highestBrightness() {
        let state = UIApplication.shared.applicationState
        if UIScreen.main.brightness < 1.0 && state != .background{
               userBrightness = UIScreen.main.brightness
           }
           UIScreen.main.brightness = 1.0
       }
       
       @objc func viewGoToBackground() {
           backToUserBrightness()
       }
    
        @objc func comesFromBackground() {
            backToUserBrightness()
        }
}

// MARK: - SignatureDetailsViewControllerProtocol
extension SignatureDetailsViewController: SignatureDetailsViewControllerProtocol {
 
    func showDetails(_ details: SignatureDetails.ViewModel) {
        
        self.subtitleMessageLabel.text = details.messageValue
        self.qrCodeImage.image = details.qrCodeImage
        highestBrightness()
    }
}

// MARK: - TopBar Delegate
extension SignatureDetailsViewController: TopBarViewDelegate {
    
    func topBarView(_ topBarView: TopBarView, didPressItem item: Button) {
        presenter.backPressed()
    }
}
