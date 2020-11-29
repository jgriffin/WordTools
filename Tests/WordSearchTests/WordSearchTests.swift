import Foundation
import WordSearch
import WordTools
import XCTest

final class WordSearchTests: XCTestCase {
    typealias Pos = BoardPosition

    let board = Board(["apples",
                       "banana",
                       "cherry"].map(\.characters))

    func testFindWord() {
        let search = WordSearch(board: board)

        let tests: [(word: String, check: [[Pos]])] = [
            ("apple", [(0 ..< 5).map { Pos($0, 0) }]),
            ("banana", [(0 ..< 6).map { Pos($0, 1) }].array),
            ("abc", [[Pos(0, 0), Pos(0, 1), Pos(0, 2)]]),
            ("par", [[Pos(2, 0), Pos(3, 1), Pos(4, 2)]]),
            ("grape", []),
            ("less", []),
        ]
        tests.forEach { test in
            let result = search.findWord(test.word)

            XCTAssertEqual(result, test.check, test.word)
        }
    }

    func testBoardPretty() {
        print(board.pretty())
    }

    func testBoardOnlyPositions() {
        let search = WordSearch(board: board)
        let applePositions = search.findWord("apple").flatMap { $0 }.set

        print(board.pretty(show: applePositions), "\n")
        print(board.pretty(show: board.positionsOf("apple")), "\n")

        print(board.pretty(show: board.positionsOf("apple"),
                           showBlock: { ch in CharacterMap.uppercasing[ch].flatMap { $0 } ?? ch },
                           hideBlock: { ch in CharacterMap.lowercasing[ch].flatMap { $0 } ?? ch }),
              "\n")
    }
}
