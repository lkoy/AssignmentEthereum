//
//  GetAccountWorker.swift
//  AssignmentMoneyou
//
//  Created by ttg on 23/09/2019.
//  Copyright © 2019 ttg. All rights reserved.
//

import Foundation

enum CheckStateWorkerError: Error {
    case error
}

typealias CheckStateWorkerAlias = BaseWorker<Void, Result<Bool, CheckStateWorkerError>>

final class CheckStateWorker: CheckStateWorkerAlias {
    
    override func job(completion: @escaping ((Result<Bool, CheckStateWorkerError>) -> Void)) {
        
        //Add sleep to show splash screen
        sleep(2)
        completion(.success(true))
    }
}
