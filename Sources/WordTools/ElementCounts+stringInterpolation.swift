//
// Created by John Griffin on 11/17/23
//

import Foundation

public extension String.StringInterpolation {
    // MARK: - float decimal places

    mutating func appendInterpolation(dotOne value: Float) {
        appendLiteral(String(format: "%.1f", value))
    }

    mutating func appendInterpolation(dotTwo value: Float) {
        appendLiteral(String(format: "%.2f", value))
    }

    mutating func appendInterpolation(dotTwo value: Double) {
        appendLiteral(String(format: "%.2f", value))
    }
}

public extension String.StringInterpolation {
    // MARK: - letter

    mutating func appendInterpolation(letter: some Letter) {
        if letter == .newline {
            appendLiteral("\u{2424}")
        } else {
            appendLiteral("\(letter.asCharacter)")
        }
    }

    // MARK: - counts

    mutating func appendInterpolation(
        letterCount kv: (key: some Letter, value: Int)
    ) {
        appendInterpolation("\(letter: kv.key)\t\(kv.value)")
    }

    mutating func appendInterpolation(
        letterCounts s: some Sequence<(key: some Letter, value: Int)>,
        prefix: Int = .max
    ) {
        appendInterpolation(s.prefix(prefix).map { "\(letterCount: $0)" }.joined(separator: "\n"))
    }

    // MARK: - frequencies

    mutating func appendInterpolation(
        letterDotTwo kv: (key: some Letter, value: Float)
    ) {
        appendInterpolation("\(letter: kv.key)\t\(dotTwo: kv.value)")
    }

    mutating func appendInterpolation(
        letterDotTwo s: some Sequence<(key: some Letter, value: Float)>,
        prefix: Int = .max
    ) {
        appendInterpolation(s.prefix(prefix).map { "\(letterDotTwo: $0)" }.joined(separator: "\n"))
    }

    // MARK: - ElementCounts<some Letter>

    mutating func appendInterpolation(
        letterCounts elementCounts: ElementCounts<some Letter>,
        prefix: Int = .max
    ) {
        appendLiteral("\(elementCounts.uniqueElementsCount) letters\n")
        appendLiteral("totalCount - \(elementCounts.countOf.values.reduce(0,+))\n")
        appendInterpolation("\(letterCounts: elementCounts.countOf.sorted { lhs, rhs in lhs.value > rhs.value }, prefix: prefix)")
    }

    mutating func appendInterpolation(
        letterAsPercentages elementCounts: ElementCounts<some Letter>,
        prefix: Int = .max
    ) {
        let percentages = elementCounts.asPercentages
        appendLiteral("\(percentages.keys.count) letters\n")
        appendInterpolation("\(letterDotTwo: percentages.sorted { lhs, rhs in lhs.value > rhs.value }, prefix: prefix)")
    }
}

public extension String.StringInterpolation {
    // MARK: - any counts

    mutating func appendInterpolation(count kv: (key: some Any, value: Int)) {
        appendInterpolation("\(kv.key)\t\(kv.value)")
    }

    mutating func appendInterpolation(
        counts s: some Sequence<(key: some Any, value: Int)>,
        prefix: Int = .max
    ) {
        appendInterpolation(s.prefix(prefix).map { "\(count: $0)" }.joined(separator: "\n"))
    }

    // MARK: - frequencies

    mutating func appendInterpolation(dotTwo kv: (key: some Any, value: Float)) {
        appendInterpolation("\(kv.key)\t\(dotTwo: kv.value)")
    }

    mutating func appendInterpolation(dotTwo s: some Sequence<(key: some Any, value: Float)>, prefix: Int = .max) {
        appendInterpolation(s.prefix(prefix).map { "\(dotTwo: $0)" }.joined(separator: "\n"))
    }

    // MARK: - LetterCounts<some Any>

    mutating func appendInterpolation(
        counts elementCounts: ElementCounts<some Any>,
        prefix: Int = .max
    ) {
        appendLiteral("\(elementCounts.uniqueElementsCount) letters\n")
        appendLiteral("totalCount - \(elementCounts.countOf.values.reduce(0,+))\n")
        appendLiteral("\(counts: elementCounts.countOf.sorted { lhs, rhs in lhs.value > rhs.value }, prefix: prefix)")
    }

    mutating func appendInterpolation(
        asPercentages elementCounts: ElementCounts<some Any>,
        prefix: Int = .max
    ) {
        let percentages = elementCounts.asPercentages
        appendLiteral("\(percentages.keys.count) letters\n")
        appendInterpolation("\(dotTwo: percentages.sorted { lhs, rhs in lhs.value > rhs.value }, prefix: prefix)")
    }
}
