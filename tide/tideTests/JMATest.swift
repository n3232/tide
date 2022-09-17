import XCTest
@testable import tide

class JMATest: XCTestCase {

    func testGetTide() {

        let jma = JMA()
        jma.getTideTxt()

        XCTAssertTrue(true)
    }

}

