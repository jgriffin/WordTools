import XCTest
@testable import WordTools

final class WordToolsTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(WordTools().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
