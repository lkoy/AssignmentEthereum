//
//  SignatureDetailsModels.swift
//  AssignmentEth
//
//  Created by ttg on 18/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import Foundation
import UIKit.UIImage

enum SignatureDetails {

    struct ViewModel: Equatable {
        
        let messageValue: String
        let qrCodeImage: UIImage
    }
}
