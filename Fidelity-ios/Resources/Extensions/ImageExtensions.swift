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
