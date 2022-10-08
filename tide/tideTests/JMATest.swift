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

    func testJma() {
        let date = calendar.date(from: DateComponents(year: 2022, month: 1, day: 1, hour: 0, minute: 0, second: 0))
        let actual = Jma().getJmaModel(date: .now, locationCode: "ZF")
        XCTAssertEqual(actual?.date, date)
        
    }

    func testDownloadTxt() async throws {
        let url = URL(string: "https://www.data.jma.go.jp/kaiyou/data/db/tide/suisan/txt/2022/ZF.txt")!
        let txt = try await Jma().downloadTxt(url: url)
        print(txt)
    }

    func testGetUrl() async throws {
        let actual = Jma().getUrl(.now, "ZF")
        let expected = URL(string: "https://www.data.jma.go.jp/kaiyou/data/db/tide/suisan/txt/2022/ZF.txt")!
        XCTAssertEqual(actual, expected)
    }

}

