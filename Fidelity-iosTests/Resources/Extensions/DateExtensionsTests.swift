//
//  DateExtensionsTests.swift
//  Fidelity-iosTests
//
//  Created by Artur Luis on 19/10/21.
//

import XCTest
@testable import Fidelity_ios

class DateExtensionsTests: XCTestCase {
    func testExample() throws {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        let date = formatter.date(from: "2011-10-05T14:48:00.000Z")
        guard let ISOString = date?.toISOString() else {
            fatalError()
        }
        let year = ISOString[...ISOString.index(ISOString.startIndex,offsetBy: 3)]
        let month = ISOString[ISOString.index(ISOString.startIndex,offsetBy: 5)...ISOString.index(ISOString.startIndex,offsetBy: 6)]
        let day = ISOString[ISOString.index(ISOString.startIndex,offsetBy: 8)...ISOString.index(ISOString.startIndex,offsetBy: 9)]
        let hours = ISOString[ISOString.index(ISOString.startIndex,offsetBy: 11)...ISOString.index(ISOString.startIndex,offsetBy: 12)]
        let minutes = ISOString[ISOString.index(ISOString.startIndex,offsetBy: 14)...ISOString.index(ISOString.startIndex,offsetBy: 15)]
        let miliseconds = ISOString[ISOString.index(ISOString.startIndex,offsetBy: 17)...ISOString.index(ISOString.startIndex,offsetBy: 22)]
        
        XCTAssertEqual(ISOString, "2011-10-05T14:48:00.000Z")
        XCTAssertEqual(year, "2011")
        XCTAssertEqual(month, "10")
        XCTAssertEqual(day, "05")
        XCTAssertEqual(hours, "14")
        XCTAssertEqual(minutes, "48")
        XCTAssertEqual(miliseconds, "00.000")
    }
}
