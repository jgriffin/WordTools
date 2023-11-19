import WordLists
import WordTools
import XCTest

final class WordListTests: XCTestCase {
    func testReadWorldlist() throws {
        let words = try WordList.wordlist.asString.split(separator: .newline)
        XCTAssertEqual(words.count, 69903)
    }

    func testWordlistStartingWithA() throws {
        let words = try WordList.wordlist.asString.split(separator: .newline)
        let startsWithA = words
            .filter { $0.starts(with: "a") }

        XCTAssertEqual(startsWithA.count, 5583)
    }
}
