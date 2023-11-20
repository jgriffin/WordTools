//
// Created by John Griffin on 11/12/23
//

import Foundation

public struct ElementCounts<Element: Hashable>: CustomStringConvertible {
    public let countOf: [Element: Int]

    public init(countOf: [Element: Int]) {
        self.countOf = countOf
    }

    public init(_ s: some Sequence<Element>) {
        self.init(countOf:
            s.reduce(into: [Element: Int]()) { counts, char in
                counts[char, default: 0] += 1
            }
        )
    }

    public var description: String {
        "\(counts: self, prefix: 5)"
    }
}

public extension ElementCounts {
    // MARK: - counts

    var totalCount: Int {
        countOf.values.reduce(0,+)
    }

    var uniqueElementsCount: Int {
        countOf.keys.count
    }

    // MARK: - map

    func map(_ mapper: ElementMapper<Element>) -> ElementCounts {
        .init(countOf:
            countOf.reduce(into: [Element: Int]()) { partialResult, pair in
                guard let letter = mapper.mapping(pair.key) else { return }
                partialResult[letter, default: 0] += pair.value
            }
        )
    }

    // MARK: - percentages

    var asProbabilies: [Element: Float] {
        let floatCount = Float(totalCount)
        return countOf.mapValues { Float($0) / floatCount }
    }

    var asPercentages: [Element: Float] {
        let floatCount = Float(totalCount)
        return countOf.mapValues { Float($0) / floatCount * 100 }
    }

    // MARK: - probability

    var asBayesianProbability: BayesianProbability<Element> {
        let probs = asProbabilies
        let uniqueElementsCount = uniqueElementsCount
        let unseenProbability = 1 / Float(uniqueElementsCount)

        return .init(
            probBGivenA: { b in
                probs[b, default: unseenProbability]
            },
            probB: { b in 
                probs[b] != nil ? unseenProbability : unseenProbability
            }
        )
    }
}

public extension ElementCounts where Element: Comparable {
    typealias SortsBeforeCount = ((key: Element, value: Int), (key: Element, value: Int)) -> Bool
    static var increasingCountsByLetter: SortsBeforeCount { { $0.key < $1.key } }
    static var decreasingCountsByLetter: SortsBeforeCount { { $0.key > $1.key } }

    typealias SortsBeforePercentage = ((key: Element, value: Float), (key: Element, value: Float)) -> Bool
    static var increasingPrecentageByLetter: SortsBeforePercentage { { $0.value < $1.value } }
    static var decreasingPercentageByLetter: SortsBeforePercentage { { $0.value > $1.value } }
}
