//
//  Error+Info.swift
//
//  Created by Iglesias, Gustavo on 16/12/2019.
//  Copyright © 2019 ttg. All rights reserved.
//

import Foundation

extension Error {
    
    var code: Int {
        let error = self as NSError
        return error.code
    }
}
