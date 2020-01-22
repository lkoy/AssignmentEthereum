//
//  CameraPermissionStatus.swift
//  AssignmentEth
//
//  Created by Iglesias, Gustavo on 18/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import Foundation
import AVFoundation

protocol CameraPermissionStatus {
    var status: CameraStatus { get }
}

enum CameraStatus {
    case authorized
    case denied
    case notDetermined
    case unknownStatus
}

final class DeviceCameraPermissionStatus: CameraPermissionStatus {
    
    var status: CameraStatus {
        switch AVCaptureDevice.authorizationStatus(for: AVMediaType.video) {
        case .notDetermined:
            return .notDetermined
        case .denied, .restricted:
            return .denied
        case .authorized:
            return .authorized
        @unknown default:
            return .unknownStatus
        }
    }
    
}
