//
//  Letter.swift
//
//
//  Created by Griff on 11/26/20.
//

import Foundation

/**
 Abstraction over Character and Ascii for puzzles where we're interested in Ascii characters
 */
public protocol Letter: Hashable, Comparable {
    static var asciiLetters: [Self] { get }
    static var newline: Self { get }
    static var space: Self { get }
    static var tilde: Self { get }

    static var uppercaseLetters: [Self] { get }
    static var lowercaseLetters: [Self] { get }
    static var alphaLetters: [Self] { get }
    static var numericLetters: [Self] { get }
    static var alphaNumericLetters: [Self] { get }
    static var punctuationLetters: [Self] { get }
    static var symbolLetters: [Self] { get }

    var asCharacter: Character { get }
}

// MARK: - sets and dictionaries

public extension Set where Element: Letter {
    static var isAscii: Self { Element.asciiLetters.asSet }
    static var isUppercase: Self { Element.uppercaseLetters.asSet }
    static var isLowercase: Self { Element.lowercaseLetters.asSet }
    static var isAalpha: Self { Element.alphaLetters.asSet }
    static var isNumeric: Self { Element.numericLetters.asSet }
    static var isAlphaNumeric: Self { Element.alphaNumericLetters.asSet }
}

public extension Dictionary where Key: Letter, Key == Value {
    static var toUppercase: Self { Dictionary(uniqueKeysWithValues: zip(Key.lowercaseLetters, Key.uppercaseLetters)) }
    static var toLowercase: Self { Dictionary(uniqueKeysWithValues: zip(Key.lowercaseLetters, Key.uppercaseLetters)) }
}

public extension Letter {
    static var toUppercaseMap: [Self: Self] { .toLowercase }
    static var toLowercaseMap: [Self: Self] { .toUppercase }
}

// MARK: - Character

// can't make conformance public ... but caller can
extension Character: Letter {}

public extension Character {
    static var asciiLetters: [Character] = Ascii.asciiLetters.map(\.asCharacter)
    static let newline: Character = "\n"
    static let space: Character = " "
    static let tilde: Character = "~"

    static let uppercaseLetters: [Character] = asciiLetters.filter(\.isUppercase)
    static let lowercaseLetters: [Character] = asciiLetters.filter(\.isLowercase)
    static let alphaLetters: [Character] = asciiLetters.filter(\.isLetter)
    static let numericLetters: [Character] = asciiLetters.filter(\.isNumber)
    static let alphaNumericLetters: [Character] = alphaLetters + numericLetters
    static let punctuationLetters: [Character] = asciiLetters.filter(\.isPunctuation)
    static let symbolLetters: [Character] = asciiLetters.filter(\.isSymbol)

    var asCharacter: Character { self }
}

public extension [Character] {
    var asString: String { String(self) }
}

// MARK: - ASCII

public typealias Ascii = UInt8

// can't make conformance public ... but caller can
extension Ascii: Letter {}

public extension Ascii {
    static var asciiLetters: [Ascii] = (32 ... 126).asArray
    static let newline: Ascii = Character.newline.asciiValue!
    static let space: Ascii = Character.space.asciiValue!
    static let tilde: Ascii = Character.tilde.asciiValue!

    static let uppercaseLetters: [Ascii] = try! Character.uppercaseLetters.asAscii
    static let lowercaseLetters: [Ascii] = try! Character.lowercaseLetters.asAscii
    static let alphaLetters: [Ascii] = try! Character.alphaLetters.asAscii
    static let numericLetters: [Ascii] = try! Character.numericLetters.asAscii
    static let alphaNumericLetters: [Ascii] = try! Character.alphaNumericLetters.asAscii
    static let punctuationLetters: [Ascii] = try! Character.punctuationLetters.asAscii
    static let symbolLetters: [Ascii] = try! Character.symbolLetters.asAscii

    var asCharacter: Character { Character(UnicodeScalar(self)) }
}

public extension [Ascii] {
    var asString: String {
        get throws {
            guard let string = String(bytes: self, encoding: .ascii) else { throw AsciiError.stringConversionFailed }
            return string
        }
    }
}

public extension Sequence<Character> {
    var asString: String { String(self) }

    var asCharacters: [Character] { Array(self) }

    var asAscii: [Ascii] {
        get throws {
            try map {
                guard let ascii = $0.asciiValue else { throw AsciiError.notAscii }
                return ascii
            }
        }
    }
}

enum AsciiError: Error {
    case notAscii
    case stringConversionFailed
}
