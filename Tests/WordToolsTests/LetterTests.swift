//
// Created by John Griffin on 11/19/23
//

import WordTools
import XCTest

final class LetterTests: XCTestCase {
    func testLetters() async throws {
        let letters = #"""
         !"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~
        """#
        XCTAssertEqual(Character.asciiLetters.asString, letters)
        XCTAssertEqual(Character.lowercaseLetters.asString, "abcdefghijklmnopqrstuvwxyz")
        XCTAssertEqual(Character.uppercaseLetters.asString, "ABCDEFGHIJKLMNOPQRSTUVWXYZ")
        XCTAssertEqual(Character.alphaLetters.asString, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz")
        XCTAssertEqual(Character.numericLetters.asString, "0123456789")
        XCTAssertEqual(Character.alphaNumericLetters.asString, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789")
        XCTAssertEqual(Character.punctuationLetters.asString, ##"!"#%&'()*,-./:;?@[\]_{}"##)
        XCTAssertEqual(Character.symbolLetters.asString, "$+<=>^`|~")
    }
}
