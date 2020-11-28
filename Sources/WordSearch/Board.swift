import Algorithms
import Foundation

public struct Board<Piece: Hashable> {
    public typealias Pos = BoardPosition

    public let squares: [[Piece]]
    public let size: Pos

    public init(_ pieces: [[Piece]]) {
        let colCount = pieces.first?.count ?? 0
        guard pieces.map(\.count).allSatisfy({ $0 == colCount }) else {
            fatalError("column counts must be the same")
        }

        squares = pieces
        size = Pos(colCount, pieces.count)
    }

    public subscript(index: Pos) -> Piece {
        squares[index.y][index.x]
    }

    public func isValid(_ pos: Pos) -> Bool { pos.isValid(in: size) }

    public lazy var positionsOf: [Piece: [Pos]] = {
        product(Array(0 ..< self.size.x), Array(0 ..< size.y))
            .map { Pos($0.0, $0.1) }
            .reduce(into: [Piece: [Pos]]()) { result, pos in
                result[self[pos], default: []] += [pos]
            }
    }()

    public func makeIterator(from pos: Pos, step: BoardPosition.Step) -> AnyIterator<Pos> {
        pos.makeIterator(step, size: size)
    }
}
