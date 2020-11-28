@testable import Cryptograms
import XCTest

final class CryptogramsTests: XCTestCase {
    let quickBrownFox = "the quick brown fox jumps over the lazy dog"

    func testAnalyze() {
        let analysis = Cryptogram.analyze(Array(quickBrownFox), top: 10)
        print(analysis)
    }

    func testCryptogramPuzzle() {
        // For example, THE SMART CAT might become FVO QWGDF JGF if
        // F is substituted for T, V for H, 0 for E, and so on.

        var puzzle = CryptogramPuzzle(text: "THE SMART CAT")
        puzzle.substitute(["T": "f", "H": "v", "E": "o"])

        XCTAssertEqual(puzzle.decoded, "fvo SMARf CAf")
        puzzle.substitute(["S": "q", "M": "w", "A": "g", "R": "d", "C": "j"])

        XCTAssertEqual(puzzle.decoded, "fvo qwgdf jgf")
    }
}
