//
//  ImageExtensions.swift
//  Fidelity-ios
//
//  Created by Matheus Homrich on 14/10/21.
//

import Foundation
import UIKit

extension UIImageView {
    
    func circleImage() {
        self.layer.cornerRadius = self.frame.size.width/2
        self.clipsToBounds = true
        
    }
}

extension UIImage {
    
    func resizeByByte(maxByte: Int, completion: @escaping (Data) -> Void) {
        var compressQuality: CGFloat = 1
        var imageData = Data()
        var imageByte = self.jpegData(compressionQuality: 1)?.count
        
        while imageByte! > maxByte {
            imageData = self.jpegData(compressionQuality: compressQuality)!
            imageByte = self.jpegData(compressionQuality: compressQuality)?.count
            compressQuality -= 0.1
        }
        
        if maxByte > imageByte! {
            completion(imageData)
        } else {
            completion(self.jpegData(compressionQuality: 1)!)
        }
    }
}
