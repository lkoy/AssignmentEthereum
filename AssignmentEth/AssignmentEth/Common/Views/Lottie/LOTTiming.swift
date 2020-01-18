//
//  LOTTiming.swift
//  AssignmentEth
//
//  Created by Iglesias, Gustavo on 17/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import Foundation

public struct LOTTiming {
    
    let inFrames: InFrames
    let loopFrames: LoopFrames
    
    struct InFrames {
        let from: NSNumber = 0
        let to: NSNumber
    }
    
    struct LoopFrames {
        let from: NSNumber
        let to: NSNumber
    }
    
}
