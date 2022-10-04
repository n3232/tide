import XCTest
@testable import tide

class JMATest: XCTestCase {

    private let calendar = Calendar(identifier: .gregorian)    // 西暦（gregorian）カレンダー

    func testGetDayOfYear() {
        let date = calendar.date(from: DateComponents(year: 2020, month: 2, day: 1, hour: 0, minute: 0, second: 0))
        let actual = Jma().getDayOfYear(from: date!)
        XCTAssertEqual(actual, 32)
    }

    func testGetDayOfYear1() {
        let date = calendar.date(from: DateComponents(year: 2020, month: 1, day: 1, hour: 0, minute: 0, second: 0))
        let actual = Jma().getDayOfYear(from: date!)
        XCTAssertEqual(actual, 1)
    }

    func testGetDayOfYear365() {
        let date = calendar.date(from: DateComponents(year: 2021, month: 12, day: 31, hour: 0, minute: 0, second: 0))
        let actual = Jma().getDayOfYear(from: date!)
        XCTAssertEqual(actual, 365) 
    }

    func testGetDayOfYear366() {
        let date = calendar.date(from: DateComponents(year: 2020, month: 12, day: 31, hour: 0, minute: 0, second: 0))
        let actual = Jma().getDayOfYear(from: date!)
        XCTAssertEqual(actual, 366) // 2020年は閏年のため1日多い
    }

}

