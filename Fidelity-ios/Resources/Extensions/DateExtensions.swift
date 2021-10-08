//
//  DateExtensions.swift
//  Fidelity-ios
//
//  Created by Pedro Gomes Rubbo Pacheco on 08/10/21.
//

import Foundation

extension Date {
    func hourAfter(n: Int) -> Date {
        return Calendar.current.date(byAdding: .hour, value: n, to: self)!
    }
}
