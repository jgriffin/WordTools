//
// Created by John Griffin on 11/17/23
//

import Foundation

public extension String.StringInterpolation {
    mutating func appendInterpolation(letter: some Letter) {
        appendLiteral("\'\(letter.asCharacter)\'")
    }

    mutating func appendInterpolation(dotOne value: Float) {
        appendLiteral(String(format: "%.1f", value))
    }

    mutating func appendInterpolation(dotTwo value: Float) {
        appendLiteral(String(format: "%.2f", value))
    }

    // MARK: - counts

    mutating func appendInterpolation(count kv: (key: some Letter, value: Int)) {
        appendInterpolation("\(letter: kv.key) - \(kv.value)")
    }

    mutating func appendInterpolation(counts s: some Sequence<(key: some Letter, value: Int)>, prefix: Int = .max) {
        appendLiteral(s.prefix(prefix).map { "\(count: $0)" }.joined(separator: "\n"))
    }

    // MARK: - dotTwo

    mutating func appendInterpolation(dotTwo kv: (key: some Letter, value: Float)) {
        appendInterpolation("\(letter: kv.key) - \(dotTwo: kv.value)")
    }

    mutating func appendInterpolation(dotTwo s: some Sequence<(key: some Letter, value: Float)>, prefix: Int = .max) {
        appendLiteral(s.prefix(prefix).map { "\(dotTwo: $0)" }.joined(separator: "\n"))
    }

    // MARK: - LetterCounts

    mutating func appendInterpolation(
        counts letterCounts: LetterCounts<some Letter>,
        prefix: Int = .max
    ) {
        appendLiteral("\(letterCounts.letterCount) letters\n")
        appendLiteral("totalCount - \(letterCounts.countOf.values.reduce(0,+))\n")
        appendLiteral("\(counts: letterCounts.countOf.sorted { lhs, rhs in lhs.value > rhs.value }, prefix: prefix)")
    }

    mutating func appendInterpolation(asPercentages letterCounts: LetterCounts<some Letter>, prefix: Int = .max) {
        let percentages = letterCounts.asPercentages
        appendLiteral("\(percentages.keys.count) letters\n")
        appendLiteral("\(dotTwo: percentages.sorted { lhs, rhs in lhs.value > rhs.value }, prefix: prefix)")
    }
}
