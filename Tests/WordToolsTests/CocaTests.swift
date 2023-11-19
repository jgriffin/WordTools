//
// Created by John Griffin on 11/16/23
//

import WordLists
import WordTools
import XCTest

final class CocaTests: XCTestCase {
    func testExists() async throws {
        for list in WordList.cocaLists {
            let lines = try list.asString.split(separator: .newline)
            XCTAssertEqual(lines.count, 1)
        }
    }

    func testLetterCounts() async throws {
        let result = try WordList.coca_acad.data.prefix(.max).reduce(into: []) { $0.append($1) }
        try print(result.asString.prefix(200))

        let counts = LetterCounts(result)
        print("\(asPercentages: counts, prefix: 5)")
        print("\(asPercentages: counts.map(.uppercasedOrPass.then(.replaceNotIn(.isAlphaNumeric, with: .tilde))))")
        print("\(dotTwo: counts.map(.uppercasedOrDrop).asPercentages.sorted(by: { lhs, rhs in lhs.key < rhs.key }))")
    }

    func testAlphaCounts() async throws {
        let result = try WordList.coca_acad.data.asAscii
        try print(result.asString.prefix(200))

        let counts = LetterCounts(result)
        print("\(asPercentages: counts, prefix: 5)")
        print("\(asPercentages: counts.map(.uppercasedOrDrop)))")
    }
}
