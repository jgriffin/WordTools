import Foundation

public extension Board where Piece == Character {
    func pretty() -> String {
        squares
            .map { row in String(row) }
            .joined(separator: "\n")
    }

    func pretty(show positions: some Collection<Pos>,
                showMap: (Character) -> Character = { $0 },
                hideMap: (Character) -> Character = { _ in "." }) -> String
    {
        let positions = positions.asSet

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
