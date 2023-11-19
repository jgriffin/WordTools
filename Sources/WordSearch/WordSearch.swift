import Foundation
import WordTools

public struct WordSearch {
    public var board: Board<Character>

    public init(board: Board<Character>) { self.board = board }

    public func findWord(_ characters: some Collection<Character>,
                         directions: [BoardPosition.Step] = .allSteps) -> [[BoardPosition]]
    {
        guard let firstCh = characters.first else { return [] }

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
                            .prefix(characters.count)
                            .map { $0 }

                        guard positions.count == characters.count else { return nil }

                        return Array(positions)
                    }
            }
    }

    public func findWords<C: Collection>(_ words: some Collection<C>)
        -> (found: [(word: C, positions: [BoardPosition])],
            notFound: [C])
        where C.Element == Character
    {
        var found = [(C, [BoardPosition])]()
        var notFound = [C]()

        words.forEach { word in
            let positions = findWord(word)

            guard let first = positions.first
            else {
                notFound.append(word)
                return
            }

            found.append((word, first))
        }

        return (found, notFound)
    }

    public func prettyFindWord(_ word: some Collection<Character>) -> String {
        let positions = findWord(word)
        let lowercasing = Character.toLowercaseMap

        let prettyBoard = !positions.isEmpty ?
            board.pretty(show: positions.joined()) :
            board.pretty(show: board.positionsOf(word),
                         showMap: { ch in lowercasing[ch] ?? ch })

        return String(word) + "\n" + prettyBoard + "\n"
    }

    public func prettyFindWords(_ words: some Collection<some Collection<Character>>) -> String {
        let (found, notFound) = findWords(words)

        var output = found.map { String($0.word) }.joined(separator: ", ") + "\n"
        output += board.pretty(show: found.flatMap(\.positions)) + "\n"

        output += notFound
            .map { prettyFindWord($0) }
            .joined(separator: "\n")

        return output
    }
}
