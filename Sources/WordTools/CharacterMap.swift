//
//  File.swift
//
//
//  Created by Griff on 11/28/20.
//

import Foundation

public typealias CharacterMap = [Character: Character?]

extension CharacterMap {
    // MARK: common maps

    public static let misScannedNumbers = Self.characterMap("01",
                                                            "OI")
    public static let removeSpaces = Self.characterMap(removing: " ")
    public static let uppercasing = Self.characterMap(Character.allLowercase, Character.allUppercase)
    public static let lowercasing = Self.characterMap(Character.allUppercase, Character.allLowercase)
    public static let commonScanErrors = Self.combining(maps: .misScannedNumbers, removeSpaces, uppercasing)

    // MARK: character map builder

    public static func characterMap<C: Collection>(_ from: C, _ to: C) -> CharacterMap
        where C.Element == Character
    {
        Dictionary(uniqueKeysWithValues: zip(from.array, to.array))
    }

    public static func characterMap<C: Collection>(removing: C) -> CharacterMap
        where C.Element == Character
    {
        Dictionary(uniqueKeysWithValues: removing.map { ($0, nil) }.array)
    }

    static func combining(maps: CharacterMap...) -> CharacterMap {
        maps.dropFirst()
            .reduce(maps.first ?? [:]) { result, next in
                result.merging(next) { _, rhs in rhs }
            }
    }
}
