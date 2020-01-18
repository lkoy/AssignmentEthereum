//
//  TextFieldUnderBar.swift
//  AssignmentEth
//
//  Created by Iglesias, Gustavo on 17/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import UIKit

public protocol TextFieldDelegate: class {
    
    func textField(_ textField: TextField, didChangeValue value: String)
    func textFieldDidPressReturnKey(_ textField: TextField)
    func textFieldDidBeginEditing(_ textField: TextField)
    func textFieldDidEndEditing(_ textField: TextField)
}

public extension TextFieldDelegate {
    
    func textField(_ textField: TextField, didChangeValue value: String) {}
    func textFieldDidPressReturnKey(_ textField: TextField) {}
    func textFieldDidBeginEditing(_ textField: TextField) {}
    
    func textFieldDidEndEditing(_ textField: TextField) {}
}

public class TextField: UIView {
    
    private let titleLabel = Label(style: .body1)
    private let textField = UITextField()
    private let lineView = UIView()
    private var topRightContentView = UIView()
    private var mainContentView = UIView()
    private var topContentView = UIView()
    private var topLeftContentView = UIView()
    private var bottonContentView = UIView()
    private var rightContentWidthLayoutConstraint: NSLayoutConstraint!

    private struct ViewTraits {
        static let rightContentViewMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
        static let titleLabelMargins = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        static let textFieldMargins = UIEdgeInsets(top: 0, left: 0, bottom: 7, right: 0)
        static let textFieldHeight: CGFloat = 20
        static let mainContentHeight: CGFloat = 78
        static let topContentHeight: CGFloat = 56
        static let lineViewHeight: CGFloat = 1
        static let rigthContentMaxWidht: CGFloat = 100
        static let errorLabelMargins = UIEdgeInsets(top: 3, left: 0, bottom: 3, right: 0)
        static let captionRate: CGFloat = 0.70
        static let accessoryViewMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 0)
    }
    
    public weak var delegate: TextFieldDelegate?

    public var value: String {
        set {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 1.1
            textField.attributedText = NSAttributedString(string: newValue, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
            updateDesign()
        }
        get { return textField.text ?? "" }
    }
    
    public var title: String? {
        set {
            titleLabel.text = newValue
            textField.attributedPlaceholder = NSAttributedString(string: newValue ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.clear])
        }
        get { return titleLabel.text }
    }
    
    public enum TextFieldStatus {
        
        case normal
        case error
        case disable
    }
    
    internal var status: TextFieldStatus = .normal {
        didSet {
            switch status {
            case .normal:
                titleLabel.textColor = .appDarkGrey
                titleLabel.alpha = 1
                lineView.backgroundColor = .appViolet
                textField.isUserInteractionEnabled = true
            case .error:
                titleLabel.textColor = .red
                titleLabel.alpha = 1
                lineView.backgroundColor = .red
                textField.isUserInteractionEnabled = true
            case .disable:
                textField.isUserInteractionEnabled = false
                textField.textColor = .appMidGrey
                titleLabel.textColor = .appMidGrey
                titleLabel.alpha = 1
                lineView.backgroundColor = .appMidGrey
            }
        }
    }
    
    public var keyboardType: UIKeyboardType {
        
        set { textField.keyboardType = newValue }
        get { return textField.keyboardType }
    }
    
    public var returnKeyType: UIReturnKeyType {
        
        set { textField.returnKeyType = newValue }
        get { return textField.returnKeyType }
    }
    
    internal var isSecureTextEntry: Bool {
        
        set { textField.isSecureTextEntry = newValue }
        get { return textField.isSecureTextEntry }
    }
    
    public required init() {
        
        super.init(frame: CGRect.zero)
        
        setupComponentes()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        
        super.layoutSubviews()
        
        updateDesign()
    }
    
    private func setupComponentes() {
        
        backgroundColor = .clear
        
        mainContentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mainContentView)
        
        topContentView.translatesAutoresizingMaskIntoConstraints = false
        mainContentView.addSubview(topContentView)
        
        topLeftContentView.translatesAutoresizingMaskIntoConstraints = false
        topContentView.addSubview(topLeftContentView)
        
        topRightContentView.translatesAutoresizingMaskIntoConstraints = false
        topContentView.addSubview(topRightContentView)
        
        bottonContentView.translatesAutoresizingMaskIntoConstraints = false
        mainContentView.addSubview(bottonContentView)
        
        titleLabel.isUserInteractionEnabled = false
        titleLabel.minimumScaleFactor = 0.3
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.numberOfLines = 0
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        titleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        topLeftContentView.addSubview(titleLabel)
        
        textField.delegate = self
        textField.font = .body1
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        topLeftContentView.addSubview(textField)
        
        lineView.backgroundColor = .appMidGrey
        lineView.translatesAutoresizingMaskIntoConstraints = false
        bottonContentView.addSubview(lineView)
    }
    
    private func setupConstraints() {
        
        rightContentWidthLayoutConstraint = topRightContentView.widthAnchor.constraint(equalToConstant: ViewTraits.rightContentViewMargins.right)
        NSLayoutConstraint.activate([
            
            mainContentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainContentView.topAnchor.constraint(equalTo: topAnchor),
            mainContentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainContentView.heightAnchor.constraint(equalToConstant: ViewTraits.mainContentHeight),
            mainContentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            topContentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topContentView.topAnchor.constraint(equalTo: topAnchor),
            topContentView.bottomAnchor.constraint(equalTo: bottonContentView.topAnchor),
            topContentView.heightAnchor.constraint(equalToConstant: ViewTraits.topContentHeight),
            topContentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            topLeftContentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topLeftContentView.topAnchor.constraint(equalTo: topAnchor),
            topLeftContentView.bottomAnchor.constraint(equalTo: bottonContentView.topAnchor),
            
            topRightContentView.leadingAnchor.constraint(equalTo: topLeftContentView.trailingAnchor),
            topRightContentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topRightContentView.topAnchor.constraint(equalTo: topAnchor),
            topRightContentView.widthAnchor.constraint(lessThanOrEqualToConstant: ViewTraits.rigthContentMaxWidht),
            topRightContentView.bottomAnchor.constraint(equalTo: bottonContentView.topAnchor),

            rightContentWidthLayoutConstraint,
            
            bottonContentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottonContentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottonContentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottonContentView.topAnchor.constraint(equalTo: topContentView.bottomAnchor),

            textField.leadingAnchor.constraint(equalTo: topLeftContentView.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: topRightContentView.leadingAnchor),
            textField.bottomAnchor.constraint(equalTo: topLeftContentView.bottomAnchor, constant: -ViewTraits.textFieldMargins.bottom),
            textField.heightAnchor.constraint(equalToConstant: ViewTraits.textFieldHeight),

            lineView.leadingAnchor.constraint(equalTo: bottonContentView.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: bottonContentView.trailingAnchor),
            lineView.topAnchor.constraint(equalTo: bottonContentView.topAnchor, constant: -ViewTraits.lineViewHeight),
            lineView.heightAnchor.constraint(equalToConstant: ViewTraits.lineViewHeight)])
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        textField.becomeFirstResponder()
    }
    
    @objc internal func textFieldDidChange(_ textField: UITextField) {
        
        delegate?.textField(self, didChangeValue: textField.text ?? "")
    }
    
    private func updateDesign() {
        
        if self.textField.text?.isEmpty ?? true {
            titleLabel.transform = .identity
            titleLabel.frame = CGRect(x: 0,
                                      y: ViewTraits.titleLabelMargins.top,
                                      width: mainContentView.frame.width,
                                      height: ViewTraits.textFieldHeight)
        } else if titleLabel.transform == CGAffineTransform.identity, titleLabel.frame.width > 0 {
            let originalTransform = titleLabel.transform
            let scaledTransform = originalTransform.scaledBy(x: ViewTraits.captionRate, y: ViewTraits.captionRate)
            titleLabel.transform = scaledTransform
            titleLabel.frame = CGRect(x: 0,
                                      y: ViewTraits.titleLabelMargins.top / 2,
                                      width: mainContentView.frame.width * ViewTraits.captionRate,
                                      height: ViewTraits.textFieldHeight)
        } else {
            titleLabel.frame = CGRect(x: 0,
                                      y: ViewTraits.titleLabelMargins.top / 2,
                                      width: mainContentView.frame.width * ViewTraits.captionRate,
                                      height: ViewTraits.textFieldHeight)
        }
    }
}

extension TextField: UITextFieldDelegate {
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        
        guard status != .disable else {
            return
        }
        
        if self.textField.text?.isEmpty ?? true {
            let originalTransform = self.titleLabel.transform
            let scaledTransform = originalTransform.scaledBy(x: ViewTraits.captionRate, y: ViewTraits.captionRate)

            UIView.animate(withDuration: 0.3, animations: {
                self.titleLabel.transform = scaledTransform
                self.titleLabel.frame = CGRect(x: 0,
                                          y: ViewTraits.titleLabelMargins.top / 2,
                                          width: self.mainContentView.frame.width * ViewTraits.captionRate,
                                          height: ViewTraits.textFieldHeight)
            })
        }
        
        self.delegate?.textFieldDidBeginEditing(self)
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        
        if self.textField.text?.isEmpty ?? true {
            UIView.animate(withDuration: 0.3, animations: {
                self.titleLabel.transform = .identity
                self.titleLabel.frame = CGRect(x: 0,
                                               y: ViewTraits.titleLabelMargins.top,
                                               width: self.mainContentView.frame.width,
                                               height: ViewTraits.textFieldHeight)
            })
        }
        
        self.delegate?.textFieldDidEndEditing(self)
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard status != .disable else {
            return false
        }
        return true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.textFieldDidPressReturnKey(self)
        return true
    }
    
}
