//
//  Label.swift
//  AssignmentEth
//
//  Created by Iglesias, Gustavo on 17/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import UIKit

public class Label: UILabel {
    
    public enum Style: CaseIterable {
        case title1
        case title2
        case subtitle1
        case body1
        case button
        
        public var name: String { return String(describing: self) }
        public var description: String { return String(reflecting: self) }
        
        public var numberOfLines: Int {
            switch self {
            default: return 0
            }
        }
        
        public var font: UIFont {
            switch self {
            case .title1: return UIFont.title1
            case .title2: return UIFont.title2
            case .subtitle1: return UIFont.subtitle1
            case .body1: return UIFont.body1
            case .button: return UIFont.button
            }
        }
        
        public var color: UIColor {
            switch self {
            case .title1: return UIColor.appBlack
            case .title2: return UIColor.appBlack
            case .subtitle1: return UIColor.appDarkGrey
            case .body1: return UIColor.appDarkGrey
            default: return UIColor.appDarkGrey
            }
        }
        
        public var size: CGFloat {
            switch self {
            case .title1: return 30
            case .title2: return 15
            case .subtitle1: return 16
            case .body1: return 16
            case .button: return 14
            }
        }
    }
    
    private var lineHeight: CGFloat
    private var letterSpacing: CGFloat
    
    public var style: Style = .body1 {
        didSet {
            if oldValue != style {
                updateStyle()
            }
        }
    }
    
    public var underlined: Bool = false
    
    public var labelColor: UIColor? {
        didSet {
            if oldValue != labelColor {
                updateStyle()
            }
        }
    }
    
    private final var paragraphStyle: NSParagraphStyle {
        let style = NSMutableParagraphStyle()
        style.alignment = textAlignment
        style.lineBreakMode = lineBreakMode
        return style
    }
    
    override public var text: String? {
        set {
            if shouldUpdateText(old: text, new: newValue) {
                updateStyle()
                super.text = newValue
                }
            }
        get { return super.text }
    }
    
    public convenience init(style: Style = .body1, text: String? = nil) {
        
        self.init(frame: CGRect.zero)
        
        self.style = style
        self.text = text
        self.numberOfLines = 0
        updateStyle()
    }
    
    private override init(frame: CGRect) {
        
        self.lineHeight = 1.3
        self.letterSpacing = 0.0
        self.underlined = false
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateStyle() {
        
        lineBreakMode = .byTruncatingTail
        textColor = labelColor ?? style.color
        font = style.font
    }
    
    private func shouldUpdateText(old: String?, new: String?) -> Bool {
        
        guard text != nil else {
            return true
        }
        
        return old != new
    }
}
