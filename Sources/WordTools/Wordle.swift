//
// Created by John Griffin on 4/1/22
//

import Foundation
import WordLists

public enum Wordle {
    public static let words = try! Wordlist.wordle.asString.split(separator: .newline)
}
