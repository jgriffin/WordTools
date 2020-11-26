
@testable import WordTools
import XCTest

final class WordListSotedTests: XCTestCase {
    func testSortLettersLowercase() {
        let tests: [(string: String, check: String)] = [
            ("", ""),
            ("abcd", "abcd"),
            ("dcba", "abcd"),
        ]

        tests.forEach { test in
            XCTAssertEqual(test.string.sortLetters(), test.check)
        }
    }

    func testSortLettersCapitalsFirst() {
        let tests: [(string: String, check: String)] = [
            ("aA", "Aa"),
            ("aBcD", "BDac"),
        ]

        tests.forEach { test in
            XCTAssertEqual(test.string.sortLetters(), test.check)
        }
    }

    func testLettersAreSorted() {
        let tests: [(string: String, check: Bool)] = [
            ("", true),
            ("a", true),
            ("abcd", true),
            ("aabbd", true),
            ("aA", false),
            ("aBcD", false),
        ]

        tests.forEach { test in
            XCTAssertEqual(test.string.areLettersSorted, test.check)
        }
    }

    func testIsSortedSubset() {
        let tests: [(test: String, other: String, check: Bool?)] = [
            ("", "", true),
            ("", "a", true),
            ("a", "a", true),
            ("a", "ab", true),
            ("a", "aa", true),
            ("b", "a", false),
            ("ab", "a", false),
            ("ab", "aab", true),
            ("aab", "ab", false),
        ]

        tests.forEach { test in
            XCTAssertEqual(test.test.isSortedSubset(of: test.other),
                           test.check,
                           "\(test.test),\(test.other)")
        }
    }
}
