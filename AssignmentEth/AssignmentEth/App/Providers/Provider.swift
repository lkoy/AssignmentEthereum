//
//  Provider.swift
//  AssignmentEth
//
//  Created by Iglesias, Gustavo on 17/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import UIKit.UIApplication

protocol Provider {
    var configuration: AppConfiguration { get }
    var camera: CameraPermissionStatus { get set }
}

var provider: Provider { return UIApplication.provider }

class AppProvider: Provider {
    
    var configuration: AppConfiguration {
        return ConfigurationBuilder.build()
    }
    
    lazy var camera: CameraPermissionStatus = {
        return DeviceCameraPermissionStatus()
    }()
}
