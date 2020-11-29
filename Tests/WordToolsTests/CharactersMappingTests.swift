
import WordTools
import XCTest

final class CharactersMappingTests: XCTestCase {
    func testMappingString() {
        let tests: [(source: String, mapFrom: String, mapTo: String, check: String)] = [
            ("abc", "ac", "bb", "bbb"),
            ("a", "b", "c", "a"),
        ]

        tests.forEach { test in
            let result = test.source.mapping(test.mapFrom, test.mapTo)
            XCTAssertEqual(result, test.check.array)
        }
    }

    func testMappingDictionary() {
        let tests: [(source: String, map: [Character: Character?], check: String)] = [
            ("abc", ["a": "b", "c": "b"], "bbb"),
            ("abc", [:], "abc"),
            ("abc", ["b": nil], "ac"),
        ]

        tests.forEach { test in
            let result = test.source.mapping(test.map)
            XCTAssertEqual(result, test.check.array)
        }
    }
}
