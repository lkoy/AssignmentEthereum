//
//  Decimal+String.swift
//  AssignmentEth
//
//  Created by Iglesias, Gustavo on 18/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

extension Decimal {
    
    var formattedAmount: String? {
        let formatter = NumberFormatter()
        formatter.generatesDecimalNumbers = true
        formatter.usesSignificantDigits = true
        return formatter.string(from: self as NSDecimalNumber)
    }
}
