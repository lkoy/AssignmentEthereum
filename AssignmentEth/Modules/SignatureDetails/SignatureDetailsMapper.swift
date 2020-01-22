//
//  SignatureDetailsMapper.swift
//  AssignmentEth
//
//  Created by Iglesias, Gustavo on 18/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import Foundation
import UIKit.UIImage

final class SignatureDetailsMapper {

    final func map(details: AppModels.MessageSigned, barCodeImage: UIImage?) -> SignatureDetails.ViewModel {
        
        var image: UIImage!
        if let imageQr = barCodeImage {
            image = imageQr
        } else if let imageDefault = UIImage(named: "no_image") {
            image = imageDefault
        }
        
        return SignatureDetails.ViewModel(messageValue: details.message, qrCodeImage: image)
    }
}
