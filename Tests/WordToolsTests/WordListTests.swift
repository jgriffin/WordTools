@testable import WordTools
import XCTest

final class WordListTests: XCTestCase {
    func testReadWorldlist() {
        let wordlist = WordList.standard
        XCTAssertEqual(wordlist.count, 69904)
    }

    func testWordlistStartingWithA() {
        let wordlist = WordList.standard
        let startsWithA = wordlist
            .filter { $0.starts(with: "a") }

        XCTAssertEqual(startsWithA.count, 5583)
    }
}
