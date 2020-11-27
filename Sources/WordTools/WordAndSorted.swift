//
//  StringProtocol+sortLetters.swift
//
//
//  Created by Griff on 11/25/20.
//

import Foundation

public struct WordAndSorted<S: StringProtocol> {
    public let word: S
    public let sorted: [Character]

    public init(_ word: S, _ sorted: [Character]) {
        self.word = word
        self.sorted = sorted
    }
}

extension WordAndSorted {
    // isSortedSubset(of:) - all characters exist in other
    // assumes sorted strings as input
    public func isSubset<S: StringProtocol>(of other: WordAndSorted<S>) -> Bool {
        var selfIt = sorted.makeIterator()
        var otherIt = other.sorted.makeIterator()

        var s = selfIt.next()
        var o = otherIt.next()

        while s != nil, o != nil {
            guard s! >= o! else { return false }

            if s! == o! {
                s = selfIt.next()
                o = otherIt.next()
            } else {
                o = otherIt.next()
            }
        }

        return s == nil
    }

    public func diffSorted<S: StringProtocol>(_ other: WordAndSorted<S>) -> WordAndSortedDiff {
        diffSorted(other.sorted)
    }

    public func diffSorted(_ otherCharacters: [Character]) -> WordAndSortedDiff {
        var leftOnly = [Character]()
        var rightOnly = [Character]()

        var selfIt = sorted.makeIterator()
        var otherIt = otherCharacters.makeIterator()
        var s = selfIt.next()
        var o = otherIt.next()

        while s != nil, o != nil {
            if s! < o! {
                leftOnly.append(s!)
                s = selfIt.next()
            } else if s! > o! {
                rightOnly.append(o!)
                o = otherIt.next()
            } else {
                s = selfIt.next()
                o = otherIt.next()
            }
        }

        if let s = s {
            leftOnly.append(s)
        }

        if let o = o {
            rightOnly.append(o)
        }

        return (leftOnly: leftOnly, rightOnly: rightOnly)
    }
}

public typealias WordAndSortedDiff = (leftOnly: [Character], rightOnly: [Character])

extension StringProtocol {
    public func wordAndSorted() -> WordAndSorted<Self> {
        WordAndSorted(self, sorted())
    }
}
