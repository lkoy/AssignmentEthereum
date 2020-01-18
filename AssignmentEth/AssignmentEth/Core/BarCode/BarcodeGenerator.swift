//
//  BarcodeGenerator.swift
//  AssignmentEth
//
//  Created by Iglesias, Gustavo on 18/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import UIKit.UIImage
import AVFoundation

class BarcodeGenerator {
    
    func generate(code: String) -> UIImage? {
        let data = code.data(using: String.Encoding.ascii)
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            if let output = filter.outputImage {
                let scaledImage = output.transformed(by: CGAffineTransform(scaleX: UIScreen.main.scale, y: UIScreen.main.scale))
                return UIImage(ciImage: scaledImage)
            }
        }
        return nil
    }
}
