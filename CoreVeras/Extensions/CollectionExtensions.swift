//
//  CollectionExtensions.swift
//  CoreVeras
//
//  Created by Pedro Gomes Rubbo Pacheco on 09/11/21.
//

import Foundation

extension Collection where Element == Int {
    var digitoCNPJ: Int {
        var number = 1
        let digit = 11 - reversed().reduce(into: 0) {
            number += 1
            $0 += $1 * number
            if number == 9 { number = 1 }
        } % 11
        return digit > 9 ? 0 : digit
    }
}
