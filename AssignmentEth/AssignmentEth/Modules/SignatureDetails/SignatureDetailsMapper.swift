//
//  SignatureDetailsMapper.swift
//  AssignmentEth
//
//  Created by Iglesias, Gustavo on 18/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import Foundation

final class SignatureDetailsMapper {

    final func map(details: AppModels.MessageSigned) -> SignatureDetails.ViewModel {
        
        return SignatureDetails.ViewModel(messageValue: details.message, signedMessageValue: details.signedMessage)
    }
}
