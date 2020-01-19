//
//  Button.swift
//  AssignmentEth
//
//  Created by Iglesias, Gustavo on 17/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import UIKit
import Lottie

public class Button: UIControl, Pulseable {
    
    public enum Size {
        case regular
        case image
        
        var labelStyle: Label.Style {
            switch self {
            case .regular, .image: return .button
            }
        }
        
    }
    
    public enum Style: Int, CaseIterable {
        case blue
        case image
        
        public var name: String { return String(describing: self).capitalized }
        public var description: String { return String(reflecting: self) }
    }
    
    private enum ViewTraits {
        static let margins = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        static let imageMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        static let miniMargins = UIEdgeInsets(top: 0, left: 16, bottom: -2, right: 16)
        static let minWidth: CGFloat = 96
        static let height: CGFloat = 36
        static let imageHeight: CGFloat = 40
        static let imageWidth: CGFloat = 40
        static let leadingLoading: CGFloat = 4
        static let borderRadius: CGFloat = 4
        static let shadow: CALayer.Shadow = .dp4
        static let pressedShadow: CALayer.Shadow = .dp1
    }
    
    private let pulseView: UIView = .init()
    public var pulse: Pulse?
    public var pulseLayer: CALayer? { return pulse?.pulseLayer }
    public var pulseAnimation: PulseAnimation = .centreTouchRadial
    
    private var titleLabel: Label!
    private var loadingTiming: LOTTiming!
    private var loadingView: LOTAnimationView!
    
    private var imageView: UIImageView!
    
    private var widthLayoutConstraint: NSLayoutConstraint!
    private var heightLayoutConstraint: NSLayoutConstraint!
    private var leadingLayoutConstraint: NSLayoutConstraint!
    private var trailingLayoutConstraint: NSLayoutConstraint!
    
    public var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    private let size: Size
    
    public var style: Style = .blue {
        didSet {
            if oldValue != style {
                reloadStyle()
            }
        }
    }
    
    public var textAlignement: NSTextAlignment = .center
    
    public var isLoading: Bool = false {
        didSet {
            if oldValue != isLoading {
                if isLoading {
                    startLoading()
                } else {
                    stopLoading()
                }
            }
        }
    }
    
    public var imageName: String = "" {
        didSet {
            imageView.image = UIImage(named: imageName)
        }
    }
    
    override public var isEnabled: Bool {
        didSet {
            if oldValue != isEnabled {
                reloadStyle()
            }
        }
    }
    
    override public var tintColor: UIColor! {
        didSet {
            titleLabel.labelColor = tintColor
        }
    }
    
    public convenience init(style: Style = .blue, size: Size = .regular, enabled: Bool = true) {
        self.init(frame: CGRect.zero, size: size)
        
        self.loadingTiming = LOTTiming(inFrames: LOTTiming.InFrames(to: 38), loopFrames: LOTTiming.LoopFrames(from: 38, to: 146))
        self.style = style
        self.isEnabled = enabled
        reloadStyle()
    }
    
    private init(frame: CGRect, size: Size = .regular) {
        self.size = size
        super.init(frame: frame)
        
        layer.cornerRadius = ViewTraits.borderRadius
        layer.borderWidth = 0
        layer.borderColor = UIColor.appBlack.cgColor
        
        pulseView.translatesAutoresizingMaskIntoConstraints = false
        pulseView.layer.cornerRadius = ViewTraits.borderRadius
        pulseView.isUserInteractionEnabled = false
        addSubview(pulseView)
        pulse = Pulse(pulseView: self, pulseLayer: pulseView.layer)
        
        titleLabel = Label(style: size.labelStyle)
        titleLabel.setContentHuggingPriority(.required, for: .horizontal)
        titleLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.isUserInteractionEnabled = false
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 1
        addSubview(titleLabel)
        
        loadingView = LOTAnimationView()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.isUserInteractionEnabled = false
        loadingView.contentMode = .scaleAspectFit
        loadingView.isHidden = true
        addSubview(loadingView)
        
        imageView = UIImageView()
        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        
        addTarget(self, action: #selector(didTouchDownButton(sender:forEvent:)), for: .touchDown)
        addTarget(self, action: #selector(didTouchUpInsideButton(sender:)), for: .touchUpInside)
        addTarget(self, action: #selector(didTouchCancelButton(sender:)), for: .touchUpOutside)
        addTarget(self, action: #selector(didTouchCancelButton(sender:)), for: .touchDragOutside)
        addTarget(self, action: #selector(didTouchCancelButton(sender:)), for: .touchCancel)
        
        addCustomConstraints()
        reloadStyle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func addCustomConstraints() {
        
        leadingLayoutConstraint = titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor)
        trailingLayoutConstraint = titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        
        var height: CGFloat!
        var width: CGFloat!
        var top: CGFloat!
        var bottom: CGFloat!
        
        switch size {
        case .image:
            height = ViewTraits.imageHeight
            width = ViewTraits.imageWidth
            top = ViewTraits.margins.top
            bottom = ViewTraits.margins.bottom
            heightAnchor.constraint(equalToConstant: height).isActive = true
        case .regular:
            height = ViewTraits.height
            width = ViewTraits.minWidth
            top = ViewTraits.margins.top
            bottom = ViewTraits.margins.bottom
        }
        heightLayoutConstraint = titleLabel.heightAnchor.constraint(equalToConstant: height)
        widthLayoutConstraint = widthAnchor.constraint(greaterThanOrEqualToConstant: width)
        
        NSLayoutConstraint.activate([
            widthLayoutConstraint,
            heightLayoutConstraint,
            
            leadingLayoutConstraint,
            trailingLayoutConstraint,
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: top),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: bottom),
            
            pulseView.topAnchor.constraint(equalTo: topAnchor),
            pulseView.bottomAnchor.constraint(equalTo: bottomAnchor),
            pulseView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pulseView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: ViewTraits.imageMargins.top),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -ViewTraits.imageMargins.bottom),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: ViewTraits.imageMargins.left),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -ViewTraits.imageMargins.right),
            
            loadingView.centerYAnchor.constraint(equalTo: centerYAnchor),
            loadingView.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
    }
    
    private func reloadStyle() {
        var margins: UIEdgeInsets!
        switch size {
        case .regular, .image: margins = ViewTraits.margins
        }
        
        switch style {
            
        case .blue:
            layer.borderWidth = 0
            backgroundColor = isEnabled ? .appBlue : .appDarkGrey
            titleLabel.style = size.labelStyle
            titleLabel.labelColor = isEnabled ? .appWhite : UIColor.appBlack.withAlphaComponent(0.5)
            pulse?.tint = UIColor.white
            pulse?.opacity = 0.32
            leadingLayoutConstraint.constant = margins.left
            trailingLayoutConstraint.constant = -margins.right
            widthLayoutConstraint.isActive = true
            heightLayoutConstraint.isActive = true
            loadingView.setAnimation(named: "loading_action_white", bundle: Bundle.components)
            
        case .image:
            layer.borderWidth = 0
            backgroundColor = .clear
            layer.cornerRadius = 0
            imageView.isHidden = false
            titleLabel.labelColor = .clear
            leadingLayoutConstraint.constant = 0
            trailingLayoutConstraint.constant = 0
            widthLayoutConstraint.isActive = false
            heightLayoutConstraint.isActive = true
        }
        setNeedsUpdateConstraints()
    }
    
    private func startLoading() {
        self.isUserInteractionEnabled = false
        titleLabel.alpha = 0
        loadingView.isHidden = false
        loadingView.loopAnimation = false
        loadingView.play(toFrame: loadingTiming.inFrames.to) { [weak self] (_) in
            guard let self = self else { return }
            self.loadingView.loopAnimation = true
            self.loadingView.play(fromFrame: self.loadingTiming.loopFrames.from, toFrame: self.loadingTiming.loopFrames.to, withCompletion: nil)
        }
        bringSubviewToFront(loadingView)
    }
    
    private func stopLoading() {
        self.isUserInteractionEnabled = true
        titleLabel.alpha = 1
        loadingView.isHidden = true
        loadingView.stop()
    }
    
    // MARK: - Actions
    
    @objc func didTouchDownButton(sender: Any?, forEvent event: UIEvent) {
        
        layer.removeShadow()
        guard let touch = event.touches(for: self)?.first else { return }
        pulse?.start(centre: touch.location(in: self))
    }
    
    @objc func didTouchUpInsideButton(sender: Any?) {
        
        pulse?.stop()
        layer.removeShadow()
    }
    
    @objc func didTouchCancelButton(sender: Any?) {
        
        pulse?.stop()
        layer.removeShadow()
    }
    
}
