//
// Created by John Griffin on 11/12/23
//

import Foundation

public struct LetterCounts<Char: Letter>: CustomStringConvertible {
    public let countOf: [Char: Int]

    public init(countOf: [Char: Int]) {
        self.countOf = countOf
    }

    public init(_ s: some Sequence<Char>) {
        self.init(countOf:
            s.reduce(into: [Char: Int]()) { counts, char in
                counts[char, default: 0] += 1
            }
        )
    }

    public var description: String {
        "\(counts: self, prefix: 5)"
    }
}

public extension LetterCounts {
    // MARK: - counts

    var totalCount: Int {
        countOf.values.reduce(0,+)
    }

    var letterCount: Int {
        countOf.keys.count
    }

    // MARK: - percentages

    var asPercentages: [Char: Float] {
        let floatCount = Float(totalCount)
        return countOf.mapValues { Float($0) / floatCount * 100 }
    }

    // MARK: - map

    func map(_ mapper: ElementMapper<Char>) -> LetterCounts {
        .init(countOf:
            countOf.reduce(into: [Char: Int]()) { partialResult, pair in
                guard let letter = mapper.mapping(pair.key) else { return }
                partialResult[letter, default: 0] += pair.value
            }
        )
    }
}

public extension LetterCounts {
    typealias SortsBeforeCount = ((key: Char, value: Int), (key: Char, value: Int)) -> Bool
    static var increasingCountsByLetter: SortsBeforeCount { { $0.key < $1.key } }
    static var decreasingCountsByLetter: SortsBeforeCount { { $0.key > $1.key } }

    typealias SortsBeforePercentage = ((key: Char, value: Float), (key: Char, value: Float)) -> Bool
    static var increasingPrecentageByLetter: SortsBeforePercentage { { $0.value < $1.value } }
    static var decreasingPercentageByLetter: SortsBeforePercentage { { $0.value > $1.value } }
}
