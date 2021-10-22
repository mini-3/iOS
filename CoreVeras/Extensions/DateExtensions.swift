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
    
    func toISOString() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        return formatter.string(from: self)
    }
}
