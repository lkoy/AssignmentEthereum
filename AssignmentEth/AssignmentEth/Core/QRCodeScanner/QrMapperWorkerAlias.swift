//
//  QRMapper.swift
//  AssignmentEth
//
//  Created by Iglesias, Gustavo on 18/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import Foundation

typealias QrMapperWorkerAlias = BaseWorker<[String], String>
final class QrMapperWorker: QrMapperWorkerAlias {
    
    override func job(input: [String], completion: @escaping (String) -> Void) {
        let signature = mapQr(input)
        completion(signature)
    }
    
    private func mapQr(_ qrs: [String]) -> String {
        var result =  ""
        
        if let qrResult = qrs.first {
            result = qrResult
        }
        return result
    }
}
