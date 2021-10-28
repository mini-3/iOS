//
//  NSMutableData.swift
//  CoreVeras
//
//  Created by Artur Luis on 27/10/21.
//

import Foundation

extension NSMutableData {
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}
