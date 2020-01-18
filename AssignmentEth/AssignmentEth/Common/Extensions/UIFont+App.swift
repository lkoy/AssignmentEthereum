//
//  UIFont+App.swift
//  AssignmentEth
//
//  Created by Iglesias, Gustavo on 17/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import UIKit.UIFont
    
extension UIFont {
    
    open class func appFont(ofSize fontSize: CGFloat) -> UIFont {
        
        return scaled(font: UIFont.systemFont(ofSize: fontSize))
    }
    
    open class func boldAppFont(ofSize fontSize: CGFloat) -> UIFont {
        
        return scaled(font: UIFont.boldSystemFont(ofSize: fontSize))
    }
    
    private class func scaled(font: UIFont) -> UIFont {
        
        let scaledFont = UIFontMetrics.default.scaledFont(for: font)
        return scaledFont
    }
}
