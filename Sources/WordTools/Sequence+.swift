//
//  File.swift
//
//
//  Created by Griff on 11/28/20.
//

import Foundation

extension Sequence where Element: Hashable {
    public var set: Set<Element> { Set(self) }

    public func filterInSet(_ set: Set<Element>) -> [Element] {
        filter { set.contains($0) }
    }
}

extension Sequence {
    public var array: [Element] { Array(self) }
}
