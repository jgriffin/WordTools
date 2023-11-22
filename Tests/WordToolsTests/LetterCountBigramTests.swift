//
// Created by John Griffin on 11/21/23
//

import WordLists
import WordTools
import XCTest

final class LetterCountBigramTests: XCTestCase {
    let text = try! Wordlist.mit_wordlist_10000.data.asAscii

    func testBigramModel() throws {
        let counts = ElementCounts(text.windows(ofCount: 2))

        print("\(lettersCounts: counts, prefix: 10)")
        print("\(lettersAsPercentages: counts, prefix: 10)")
    }
}
