//
//  QRMapper.swift
//  AssignmentEth
//
//  Created by Iglesias, Gustavo on 18/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import Foundation

typealias QrMapperWorkerAlias = BaseWorker<[String], [(station: Int, pump: Int)]>
final class QrMapperWorker: QrMapperWorkerAlias {
    
    private let separator: String = "#"
    
    override func job(input: [String], completion: @escaping ([(station: Int, pump: Int)]) -> Void) {
        let pumps = mapQrs(input)
        completion(pumps)
    }
    
    private func mapQrs(_ qrs: [String]) -> [(station: Int, pump: Int)] {
        var result =  [(station: Int, pump: Int)]()
        for qr in qrs.unique {
            if let station = mapStation(qr), let pump = mapPump(qr) {
                result.append((station: station, pump: pump))
            }
        }
        return result
    }
    
    private func mapStation(_ qr: String) -> Int? {
        guard qr.components(separatedBy: separator).count == 2,
            let stationString = qr.components(separatedBy: separator).first,
            let station = Int(stationString) else {
                return nil
        }
        return station
    }
    
    private func mapPump(_ qr: String) -> Int? {
        guard qr.components(separatedBy: separator).count == 2,
            let pumpString = qr.components(separatedBy: separator).last,
            let pump = Int(pumpString) else {
                return nil
        }
        return pump
    }
    
}
