//
//  MockCameraPermissionStatus.swift
//  AssignmentEthTests
//
//  Created by Iglesias, Gustavo on 20/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import Foundation

@testable import AssignmentEth

final class MockCameraPermissionStatus: CameraPermissionStatus {
    
    var stubStatus: CameraStatus = .authorized
    
    var status: CameraStatus {
        return stubStatus
    }

}
