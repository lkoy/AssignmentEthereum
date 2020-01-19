//
//  UIFont+AppTypo.swift
//  AssignmentEth
//
//  Created by Iglesias, Gustavo on 17/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import UIKit.UIFont

extension UIFont {

    // MARK: - Title
    
    open class var title1: UIFont { return UIFont.boldAppFont(ofSize: Label.Style.title1.size) }
    open class var title2: UIFont { return UIFont.boldAppFont(ofSize: Label.Style.title2.size) }
    open class var title3: UIFont { return UIFont.boldAppFont(ofSize: Label.Style.title3.size) }
    
    // MARK: - Subtitle

    open class var subtitle1: UIFont { return UIFont.appFont(ofSize: Label.Style.subtitle1.size) }

    // MARK: - Body
    open class var body1: UIFont { return UIFont.appFont(ofSize: Label.Style.body1.size) }
    
    // MARK: - Other

    open class var button: UIFont { return UIFont.boldAppFont(ofSize: Label.Style.button.size) }

}
