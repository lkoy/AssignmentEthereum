//
//  UIViewController+NavigarionBar.swift
//  AssignmentEth
//
//  Created by Iglesias, Gustavo on 16/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import UIKit.UIViewController

extension UIViewController {
    
    @objc open var prefersNavigationBarHidden: Bool {
        
        return false
    }
    
    @objc open var prefersNavigationBackButtonHidden: Bool {
        
        return false
    }
}
