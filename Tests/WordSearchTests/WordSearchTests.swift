//
//  File.swift
//
//
//  Created by Griff on 11/28/20.
//

import Foundation
import WordSearch
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
}
