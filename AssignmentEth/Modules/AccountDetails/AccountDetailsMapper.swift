//
//  AccountDetailsMapper.swift
//  AssignmentEth
//
//  Created by Iglesias, Gustavo on 18/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import Foundation

final class AccountDetailsMapper {

    final func map(account: AppModels.AccountDetails) -> AccountDetails.ViewModel {
        
        let balanceString = "\(account.ether) Ether"
        return AccountDetails.ViewModel(addressValue: account.address, balanceValue: balanceString)
    }
}
