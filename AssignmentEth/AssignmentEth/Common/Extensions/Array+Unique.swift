//
//  Array+Unique.swift
//  AssignmentEth
//
//  Created by Iglesias, Gustavo on 18/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import Foundation

extension Array where Element: Hashable {
    var unique: [Element] {
        return Array(Set(self))
    }
}
