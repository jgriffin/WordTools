
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

    func testSortedDiff() {
        let tests: [(test: String, other: String, check: (leftOnly: String, rightOnly: String))] = [
            ("", "", ("", "")),
            ("", "a", ("", "a")),
            ("a", "a", ("", "")),
            ("a", "ab", ("", "b")),
            ("a", "aa", ("", "a")),
            ("b", "a", ("b", "a")),
            ("ab", "a", ("b", "")),
            ("ab", "aab", ("", "a")),
            ("aab", "ab", ("a", "")),
        ]

        tests.forEach { test in
            let result = test.test.sortedDiff(test.other)
            XCTAssertTrue(result.leftOnly == test.check.leftOnly && result.rightOnly == test.check.rightOnly,
                          "\(test.test),\(test.other)")

            let reverseResult = test.other.sortedDiff(test.test)
            XCTAssertTrue(reverseResult.leftOnly == test.check.rightOnly && reverseResult.rightOnly == test.check.leftOnly,
                          "\(test.other),\(test.test)")
        }
    }
}
