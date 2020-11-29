import Foundation

extension Board where Piece == Character {
    public func pretty() -> String {
        squares
            .map { row in String(row) }
            .joined(separator: "\n")
    }

    public func pretty<CPos: Collection>(show positions: CPos,
                                         showMap: (Character) -> Character = { $0 },
                                         hideMap: (Character) -> Character = { _ in "." }) -> String
        where CPos.Element == Pos
    {
        let positions = positions.set

        return
            (0 ..< size.y).map { y in
                (0 ..< size.x).map { x -> Character in
                    let pos = Pos(x, y)
                    let ch = pieceAt(pos)
                    return positions.contains(pos) ?
                        showMap(ch) :
                        hideMap(ch)
                }
            }
            .map { rowChars in rowChars.reduce("\t") { result, next in result + [next, " "] } }
            .joined(separator: "\n")
    }
}
