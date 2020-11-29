public struct Cryptogram {
    public static func analyze(_ text: [Character], top: Int = 10) -> String {
        let alphaNums = Set(Character.allAlphaNumeric)
        let text = text.filter { alphaNums.contains($0) }

        var output: String = ""

        output += "text:  character - frequency - count\n"
        output += Self.characterFrequencies(text)
            .prefix(top)
            .map { "\t\($0.ch) - \($0.freq.toTwoDigits) - \($0.count)" }
            .joined(separator: "\n")

        output += "\nenglish: character - frequency\n"
        output += Self.englishCharacterFrequencies
            .prefix(top)
            .map { "\t\($0.ch) - \($0.freq.toTwoDigits)" }
            .joined(separator: "\n")

        return output
    }

    public static func analyze(_ text: String, top: Int = 10) -> String {
        analyze(text.characters, top: top)
    }

    public static func characterFrequencies(_ characters: [Character])
        -> [(ch: Character, count: Int, freq: Float)]
    {
        let totalCount = characters.count
        let counts = characters
            .reduce(into: [Character: Int]()) { counts, c in
                counts[c, default: 0] += 1
            }

        return counts
            .sorted(by: { lhs, rhs in lhs.value > rhs.value })
            .map { ch, count in (ch, count, Float(count) / Float(totalCount)) }
    }

    public static let englishCharacterFrequenciesTextDict: [(ch: Character, text: Float, dict: Float)] = [
        ("a", 0.082, 0.078),
        ("b", 0.015, 0.02),
        ("c", 0.028, 0.04),
        ("d", 0.043, 0.038),
        ("e", 0.13, 0.11),
        ("f", 0.022, 0.014),
        ("g", 0.02, 0.03),
        ("h", 0.061, 0.023),
        ("i", 0.07, 0.086),
        ("j", 0.0015, 0.0021),
        ("k", 0.0077, 0.0097),
        ("l", 0.04, 0.053),
        ("m", 0.024, 0.027),
        ("n", 0.067, 0.072),
        ("o", 0.075, 0.061),
        ("p", 0.019, 0.028),
        ("q", 0.00095, 0.0019),
        ("r", 0.06, 0.073),
        ("s", 0.063, 0.087),
        ("t", 0.091, 0.067),
        ("u", 0.028, 0.033),
        ("v", 0.0098, 0.01),
        ("w", 0.024, 0.0091),
        ("x", 0.0015, 0.0027),
        ("y", 0.02, 0.016),
        ("z", 0.00074, 0.0044),
    ]

    public static let englishCharacterFrequencies =
        englishCharacterFrequenciesTextDict
            .sorted(by: { lhs, rhs in lhs.text > rhs.text })
            .map { (ch: $0.ch, freq: $0.text) }
}

extension Float {
    var toTwoDigits: String {
        String(format: "%2.2f", self)
    }
}
