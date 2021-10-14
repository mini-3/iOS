//
//  QRcodeService.swift
//  Fidelity-ios
//
//  Created by Santiago del Castillo Gonzaga on 14/10/21.
//

import Foundation
import UIKit

struct QRcodeService {
    static let shared: QRcodeService = QRcodeService()
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }
}
