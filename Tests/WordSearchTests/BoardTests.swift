import Foundation
@testable import WordSearch
import WordTools
import XCTest

final class BoardAndPositionTests: XCTestCase {
    typealias Pos = BoardPosition

    let boardAbcd = Board(["ab", "cd"].map(\.characters))

    func testMakeBoard() {
        let emptyBoard = Board<Character>([])
        XCTAssertEqual(emptyBoard.size, .zero)

        let aBoard = Board([["a"]])
        XCTAssertEqual(aBoard.size, Pos(1, 1))
    }

    func testBoardSubscript() {
        let tests: [(pos: Pos, check: Character)] = [
            (Pos(0, 0), "a"),
            (Pos(1, 0), "b"),
            (Pos(0, 1), "c"),
            (Pos(1, 1), "d"),
        ]

        tests.forEach { test in
            XCTAssertEqual(boardAbcd[test.pos], test.check)
        }
    }

    func testIsValid() {
        let tests: [(pos: Pos, check: Bool)] = [
            (Pos(0, 0), true),
            (Pos(1, 1), true),
            (Pos(0, 2), false),
            (Pos(2, 0), false),
            (Pos(2, 2), false),
            (Pos(-1, 0), false),
            (Pos(0, -1), false),
            (Pos(-1, 2), false),
        ]

        tests.forEach { test in
            XCTAssertEqual(boardAbcd.isValid(test.pos), test.check, "\(test.pos)")
        }
    }

    func testStep() {
        let start = Pos.zero

        let tests: [(step: Pos, check: Pos)] = [
            (.right, Pos(1, 0)),
            (.down, Pos(0, 1)),
            (.downRight, Pos(1, 1)),
        ]

        tests.forEach { test in
            XCTAssertEqual(start + test.step, test.check)
        }
    }

    func testMakeIterator() {
        let board = boardAbcd

        let tests: [(start: Pos,
                     checkRight: String,
                     checkDown: String,
                     checkDiagonal: String)] = [
            (Pos(0, 0), "ab", "ac", "ad"),
        ]

        XCTAssertEqual(board[.zero], "a")

        tests.forEach { test in

            XCTAssertEqual(board.makeIterator(from: test.start, step: .right).map { board[$0] },
                           test.checkRight.array)
            XCTAssertEqual(board.makeIterator(from: test.start, step: .down).map { board[$0] },
                           test.checkDown.array)
            XCTAssertEqual(board.makeIterator(from: test.start, step: .downRight).map { board[$0] },
                           test.checkDiagonal.array)
        }
    }
}
