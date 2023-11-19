//
// Created by John Griffin on 11/16/23
//

import WordLists
import WordTools
import XCTest

final class LetterCountTests: XCTestCase {
    let text = try! WordList.coca_acad.asString

    func testCountsAndPercentages() throws {
        let counts = LetterCounts(text)
        let percentages = counts.asPercentages

        XCTAssertEqual(counts.countOf.keys.count, percentages.keys.count)
        XCTAssertEqual(counts.countOf["e"], 710_763)
        XCTAssertEqual(percentages["e"], 9.194199)

        print("\(heading: "counts")")
        print("\(counts: counts, prefix: 5)")

        print("\(heading: "percentages")")
        print("\(asPercentages: counts, prefix: 5)")
    }

    func testMap() throws {
        let text = try WordList.coca_acad.asString
        let freq = LetterCounts(text)

        print("\(heading: "uppercasedOrPass")")
        print("\(asPercentages: freq.map(.uppercasedOrPass), prefix: 5)")

        print("\(heading: "lowercasedOrPass")")
        print("\(asPercentages: freq.map(.lowercasedOrPass), prefix: 5)")

        print("\(heading: "lowercasedOrDrop")")
        print("\(asPercentages: freq.map(.lowercasedOrDrop), prefix: 5)")
    }

    func testAcadNonAlphanum() throws {
        let freq = LetterCounts(text)

        print("\(heading: "letters")")
        print("\(counts: freq.map(.uppercasedOrDrop), prefix: 5)")

        print("\(heading: "non-alphanumeric to ~")")
        print("\(counts: freq.map(.replaceNotIn(.isAlphaNumeric, with: "~")), prefix: 5)")

        print("\(heading: "uppercased alphanumeric")")
        print("\(asPercentages: freq.map(.uppercasedOrPass.then(.include(.isAlphaNumeric))), prefix: 10)")

        print("\(heading: "non-alphanumeric to ~ percenatage")")
        print("\(asPercentages: freq.map(.replaceNotIn(.isAlphaNumeric, with: "~")), prefix: 4)")
    }

    func testMapNonAlphaNum() throws {
        let text = try WordList.coca_acad.asString
        let freq = LetterCounts(text)

        print("letters")
        print("\(counts: freq.map(.uppercasedOrPass), prefix: 5)")

        print()
        print("non-alphanumeric to ~")
        print("\(counts: freq.map(.uppercasedOrPass.then(.replaceNotIn(.isAlphaNumeric, with: "~"))), prefix: 5)")
    }
}
