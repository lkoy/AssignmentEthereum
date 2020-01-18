//
//  TopBarView.swift
//  AssignmentEth
//
//  Created by Iglesias, Gustavo on 17/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import UIKit

public protocol TopBarViewDelegate: NSObjectProtocol {
    func topBarView(_ topBarView: TopBarView, didPressItem item: Button)
}

public final class TopBarView: UIView {
    
    weak var delegate: TopBarViewDelegate?
    
    public enum TopBarType {
        case title
        case navigation
    }
    
    private enum ViewTraits {
        static let containerMargins = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        static let buttonMargins = UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 15)
        static let buttonSize: CGFloat = 40
        static let titleMargins = UIEdgeInsets(top: 15, left: 15, bottom: 5, right: 15)
        static let subtitleMargins = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    }
    
    private let contentView = UIView()
    
    private let button: Button = {
        let btn = Button(style: .image)
        btn.imageName = "back_icon"
        return btn
    }()
    
    private var barType: TopBarType!
    
    private let titleLabel = Label(style: .title1)
    private let subtitleLabel = Label(style: .subtitle1)
    
    public var title: String? {
        set { titleLabel.text = newValue }
        get { return titleLabel.text }
    }
    
    public var subtitle: String? {
        set {
            subtitleLabel.text = newValue ?? ""
        }
        get { return subtitleLabel.text }
    }
    
    private var buttonBottomConstraint: NSLayoutConstraint!
    private var titleBottomConstraint: NSLayoutConstraint!
    private var subTitleBottomConstraint: NSLayoutConstraint!
    
    public convenience init(type: TopBarType, title: String = "", subtitle: String = "") {
        self.init(frame: CGRect.zero, type: type)
        
        self.title = title
        self.subtitle = subtitle
        self.updateCustomConstraints()
    }
    
    private init(frame: CGRect, type: TopBarType) {
        super.init(frame: frame)
        
        backgroundColor = .appWhite
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .appWhite
        addSubview(contentView)
        
        barType = type
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = (barType == .title)
        button.addTarget(self, action: #selector(didTouchUpInsideButton(sender:)), for: .touchUpInside)
        contentView.addSubview(button)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(subtitleLabel)
        
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        
        buttonBottomConstraint = button.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -ViewTraits.buttonMargins.bottom)
        titleBottomConstraint = titleLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor, constant: -ViewTraits.titleMargins.bottom)
        subTitleBottomConstraint = subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ViewTraits.containerMargins.left),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -ViewTraits.containerMargins.right),
            contentView.topAnchor.constraint(equalTo: self.topAnchor, constant: ViewTraits.containerMargins.top),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -ViewTraits.containerMargins.bottom),
            
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -ViewTraits.buttonMargins.left),
            button.widthAnchor.constraint(equalToConstant: ViewTraits.buttonSize),
            button.heightAnchor.constraint(equalToConstant: ViewTraits.buttonSize),
            button.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
        
        buttonBottomConstraint.isActive = true
        titleBottomConstraint.isActive = true
        subTitleBottomConstraint.isActive = true
    }
    
    private func updateCustomConstraints() {
        if let titleContent = title {
            if titleContent.count == 0 {
                buttonBottomConstraint.constant = 0
            }
        }
        
        if let subtitleContent = subtitle {
            if subtitleContent.count == 0 {
                titleBottomConstraint.constant = 0
                subTitleBottomConstraint.constant = 0
            }
        }
        self.layoutSubviews()
    }
    
    // MARK: - Actions
    
    @objc func didTouchUpInsideButton(sender: Any?) {
        
        delegate?.topBarView(self, didPressItem: button)
    }
}
