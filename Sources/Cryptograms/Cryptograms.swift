//
//  Cryptograms.swift
//
//
//  Created by Griff on 11/27/20.
//

import Foundation
import WordTools

public struct Cryptogram {}

public struct CryptogramPuzzle {
    public var text: [Character]
    public var substitutions: [Character: Character] = [:]

    public var decoded: String {
        String(
            text
                .map { ch in substitutions[ch] ?? ch }
        )
    }

    public mutating func substitute(_ addSubs: [Character: Character]) {
        substitutions.merge(addSubs) { (_, new) -> Character in
            new
        }
    }

    public mutating func substitute(_ chars: [Character], _ with: [Character]) {
        let subs = zip(chars, with)
            .reduce(into: [Character: Character]()) { result, pair in
                result[pair.0] = pair.1
            }
        substitutions.merge(subs) { (_, new) -> Character in
            new
        }
    }

    public mutating func substitute(_ chars: String, _ with: String) {
        substitute(chars.characters, with.characters)
    }
}

extension CryptogramPuzzle {
    public init(text: [Character]) {
        self.text = text
    }

    public init(text: String) {
        self.text = Array(text)
    }
}
