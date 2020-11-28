import Foundation

public struct BoardPosition: Hashable, CustomStringConvertible {
    // x,y is more natural to work with than row, col which is flipped
    public var x, y: Int

    public init(_ x: Int, _ y: Int) { self.x = x; self.y = y }

    // MARK: members

    public var description: String { "(\(x),\(y))" }

    public func isValid(in size: BoardPosition) -> Bool {
        outsideOrEqual(.zero) && inside(size)
    }

    static let zero = BoardPosition(0, 0)

    // MARK: operators

    public func outsideOrEqual(_ other: BoardPosition) -> Bool {
        x >= other.x && y >= other.y
    }

    public func inside(_ other: BoardPosition) -> Bool {
        x < other.x && y < other.y
    }

    static func + (_ lhs: BoardPosition, _ rhs: BoardPosition) -> BoardPosition {
        BoardPosition(lhs.x + rhs.x, lhs.y + rhs.y)
    }

    // MARK: Iterator

    public typealias Step = BoardPosition
    static let right = Step(1, 0)
    static let down = Step(0, 1)
    static let downRight = Step(1, 1)

    func makeIterator(_ step: Step, size: BoardPosition) -> AnyIterator<BoardPosition> {
        var cur = self
        return AnyIterator<BoardPosition> {
            defer { cur = cur + step }
            guard cur.isValid(in: size) else { return nil }
            return cur
        }
    }
}
