@testable import WordTools
import XCTest

final class WordListTests: XCTestCase {
    func testReadWorldlist() {
        let wordlist = WordList.wordlist.readWords()
        XCTAssertEqual(wordlist.count, 69903)
    }

    func testWordlistStartingWithA() {
        let wordlist = WordList.wordlist.readWords()
        let startsWithA = wordlist
            .filter { $0.starts(with: "a") }

        XCTAssertEqual(startsWithA.count, 5583)
    }
}
