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

    public static let lowercaseSet = Character.allLowercase.set
    public static let uppercaseSet = Character.allUppercase.set
    public static let alphaSet = Character.allAlpha.set
    public static let numericSet = Character.allNumeric.set
    public static let alphaNumericSet = Character.allAlphaNumeric.set
}

extension String {
    public var characters: [Character] { Array(self) }
}
