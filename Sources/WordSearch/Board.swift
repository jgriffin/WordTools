import Algorithms
import Foundation

public struct Board<Piece: Hashable> {
    public typealias Pos = BoardPosition

    public let squares: [[Piece]]
    public let size: Pos

    private let _positionsOf: [Piece: [Pos]]

    public init(_ pieces: [[Piece]]) {
        let colCount = pieces.first?.count ?? 0
        guard pieces.map(\.count).allSatisfy({ $0 == colCount }) else {
            fatalError("column counts must be the same")
        }

        squares = pieces
        size = Pos(colCount, pieces.count)
        _positionsOf = Self.calculatePositionsOf(pieces)
    }

    public subscript(index: Pos) -> Piece {
        squares[index.y][index.x]
    }

    public func isValid(_ pos: Pos) -> Bool { pos.isValid(in: size) }

    public func positionsOf(_ piece: Piece) -> [Pos] {
        _positionsOf[piece] ?? []
    }

    public func positionsFrom(_ pos: Pos, step: BoardPosition.Step) -> AnyIterator<Pos> {
        pos.makeIterator(step, size: size)
    }

    public func piecesFrom(_ pos: Pos, step: BoardPosition.Step) -> AnyIterator<Piece> {
        let posIt = positionsFrom(pos, step: step)
        return AnyIterator {
            posIt.next().map { self[$0] }
        }
    }

    // MARK: internal

    private static func calculatePositionsOf(_ pieces: [[Piece]]) -> [Piece: [Pos]] {
        let size = Pos(pieces.first?.count ?? 0, pieces.count)

        return product(Array(0 ..< size.x), Array(0 ..< size.y))
            .map { Pos($0.0, $0.1) }
            .reduce(into: [Piece: [Pos]]()) { result, pos in
                result[pieces[pos.y][pos.x], default: []] += [pos]
            }
    }
}
