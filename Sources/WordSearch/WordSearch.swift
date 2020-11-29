import Foundation
import WordTools

public struct WordSearch {
    public var board: Board<Character>

    public init(board: Board<Character>) { self.board = board }

    public func findWord(_ characters: [Character]) -> [[BoardPosition]] {
        guard let firstCh = characters.first else { return [] }

        let directions: [BoardPosition.Step] = [.right, .down, .downRight]

        return board.positionsOf(firstCh)
            .flatMap { firstChPos -> [[BoardPosition]] in
                directions
                    .compactMap { direction -> [BoardPosition]? in
                        guard zip(characters,
                                  board.piecesFrom(firstChPos, step: direction))
                            .allSatisfy({ pair in pair.0 == pair.1 })
                        else {
                            return nil
                        }

                        let positions = board
                            .positionsFrom(firstChPos, step: direction)
                            .map { $0 }
                            .prefix(characters.count)
                        guard positions.count == characters.count else { return nil }

                        return positions.array
                    }
            }
    }

    public func findWord(_ string: String) -> [[BoardPosition]] {
        findWord(string.characters)
    }
}
