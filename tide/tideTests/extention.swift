import Foundation


import XCTest
@testable import tide

class extention: XCTestCase {

    func testSubstring() {
        let string = "012345"
        let actual = string.subString(from: 1, to: 3)
        XCTAssertEqual(actual, "123")
    }

}
