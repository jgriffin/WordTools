extension Sequence where Element == Character {
    // MARK: mappping

    public func mapping<C: Collection>(_ from: C,
                                       _ to: C) -> [Character]
        where C.Element == Character
    {
        mapping(Dictionary(uniqueKeysWithValues: zip(from, to)))
    }

    public func mapping(_ map: CharacterMap) -> [Character] {
        compactMap { ch -> Character? in
            map[ch] ?? ch
        }
    }

    // MARK: cleaning

    public func cleaningScanned() -> [[Character]] {
        split(separator: "\n")
            .map { $0.mapping(.commonScanErrors)
            }
    }
}
