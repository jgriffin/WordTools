//
//  Character+.swift
//
//
//  Created by Griff on 11/26/20.
//

import Foundation

extension Character {
    public static let allLowercase: [Character] = Array("abcdefghijklmnopqrstuvwxyz")
    public static let allUppercase: [Character] = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    public static let allAlpha: [Character] = allLowercase + allUppercase
    public static let allNumeric: [Character] = Array("0123456789")
    public static let allAlphaNumeric: [Character] = allAlpha + allNumeric

    public static let lowercaseSet = Set(Character.allLowercase)
    public static let uppercaseSet = Set(Character.allUppercase)
    public static let alphaSet = Set(Character.allAlpha)
    public static let numericSet = Set(Character.allNumeric)
    public static let alphaNumericSet = Set(Character.allAlphaNumeric)
}

extension String {
    public var characters: [Character] { Array(self) }
}

extension Collection where Element: Hashable {
    public func filterInSet(_ set: Set<Element>) -> [Element] {
        filter { set.contains($0) }
    }
}
