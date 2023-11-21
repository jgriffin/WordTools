import Foundation

public extension Sequence where Element: Hashable {
    var asSet: Set<Element> { Set(self) }

    func filterInSet(_ set: Set<Element>) -> [Element] {
        filter { set.contains($0) }
    }
}

public extension Sequence {
    var asArray: [Element] { Array(self) }
}

public extension Collection where Element: FloatingPoint {
    var meanSquaredError: Element {
        lazy.map { $0 * $0 }.reduce(0, +) / Element(count)
    }
}
