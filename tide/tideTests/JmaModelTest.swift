import Foundation


import XCTest
@testable import tide

// 66103138165179179166147126113112123143164181186177153117 75 35  5 -8  022 1 1QL 429181145518699999999999999 93611122 7 -899999999999999

// 66103138165179179166147126113112123143164181186177153117 75 35  5 -8  0
// 22 1 1
//QL
//429181145518699999999999999 93611122 7 -899999999999999

// 毎時潮位データ    ：    　１～　７２カラム    　３桁×２４時間（０時から２３時）
//　年月日    ：    ７３～　７８カラム    　２桁×３
//　地点記号    ：    ７９～　８０カラム    　２桁英数字記号
//　満潮時刻・潮位    ：    ８１～１０８カラム    　時刻４桁（時分）、潮位３桁（ｃｍ）
//　干潮時刻・潮位    ：    １０９～１３６カラム    　時刻４桁（時分）、潮位３桁（ｃｍ）
//　※ 満（干）潮が予測されない場合、満（干）潮時刻を「9999」、潮位を「999」としています。

class JmaModelTest: XCTestCase {

    private let line =
    " 66103138165179179166147126113112123143164181186177153117 75 35  5 -8  0" +
    "22 1 1" +
    "QL" +
    " 429" + "181" +
    "1455" + "186" +
    "99999999999999" +
    " 936" + "111" +
    "22 7" + " -8" +
    "99999999999999"

    func testDate() {
        let actual = JmaModel.getDate(line)

        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = "yyMMdd"
        let expected = formatter.date(from: "220101")!

        XCTAssertEqual(actual, expected)
    }

    func testGetHourlyTideData() {
        let actual = JmaModel.getHourlyTideData(line)
        let expected = [66, 103, 138, 165, 179, 179,
                        166, 147, 126, 113, 112, 123,
                        143, 164, 181, 186, 177, 153,
                        117, 75, 35, 5, -8, 0]
        XCTAssertEqual(actual, expected)
    }

    func testGetLocation() {
        let actual = JmaModel.getLocationCode(line)
        XCTAssertEqual(actual, "QL")
    }

    func testGetHiTide1DateTime() {
        let actual = JmaModel.getTideDateTime(line, from: 80, to: 83)
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = "yyMMddHHmm"
        let expected = formatter.date(from: "2201010429")!
        XCTAssertEqual(actual, expected)
    }

    func testGetHiTide2DateTime() {
        let actual = JmaModel.getTideDateTime(line, from: 87, to: 90)
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = "yyMMddHHmm"
        let expected = formatter.date(from: "2201011455")!
        XCTAssertEqual(actual, expected)
    }

    func testGetLowTide1DateTime() {
        let actual = JmaModel.getTideDateTime(line, from: 108, to: 111)
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = "yyMMddHHmm"
        let expected = formatter.date(from: "2201010936")!
        XCTAssertEqual(actual, expected)
    }

    func testGetLowTide2DateTime() {
        let actual = JmaModel.getTideDateTime(line, from: 115, to: 118)
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = "yyMMddHHmm"
        let expected = formatter.date(from: "2201012207")!
        XCTAssertEqual(actual, expected)
    }

    func testGetHiTideLevel() {
        let actual1 = JmaModel.getTideLevel(line, from: 84, to: 86)
        XCTAssertEqual(actual1, 181)
        let actual2 = JmaModel.getTideLevel(line, from: 91, to: 93)
        XCTAssertEqual(actual2, 186)
    }

    func testGetLowTideLevel() {
        let actual1 = JmaModel.getTideLevel(line, from: 112, to: 114)
        XCTAssertEqual(actual1, 111)
        let actual2 = JmaModel.getTideLevel(line, from: 119, to: 121)
        XCTAssertEqual(actual2, -8)
    }




}
