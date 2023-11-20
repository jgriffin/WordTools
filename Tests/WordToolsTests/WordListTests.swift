import WordLists
import WordTools
import XCTest

final class WordListTests: XCTestCase {
    func testAllWordlistsExist() throws {
        for wordlist in WordList.allCases {
            _ = try wordlist.data
        }
    }

    func testAllWordlistsAscii() throws {
        for wordlist in WordList.allCases {
            XCTAssertTrue(try wordlist.data.allSatisfy(\.isValidAscii), "\(wordlist.rawValue)")
        }
    }

    func testWordlistsCount() throws {
        let words = try WordList.english_words_alpha.asString.split(separator: .newline)
        XCTAssertEqual(words.count, 370105)
    }

    func testReadWordlistAscii() throws {
        let wordlist = try WordList.english_words_alpha.data.asAscii
        var wasNonAscii = false

        try wordlist.enumerated().forEach { i, ch in
            if !ch.isValidAscii {
                try print(i, ch, wordlist.dropFirst(i - 5).prefix(20).asString)
                wasNonAscii = true
            }
        }

        XCTAssertFalse(wasNonAscii)
    }

    func testWordlistStartingWithA() throws {
        let words = try WordList.english_words_alpha.asString.split(separator: .newline)
        let startsWithA = words
            .filter { $0.starts(with: "a") }

        XCTAssertEqual(startsWithA.count, 5583)
    }

    func testLetterCounts() throws {
        let words = try WordList.english_words_alpha.data.asAscii
        let counts = LetterCounts(words)

        print(counts)
    }
}
