//
//  StringProtocol+sortLetters.swift
//
//
//  Created by Griff on 11/25/20.
//

import Foundation

extension StringProtocol {
    public func sortLetters() -> String {
        String(self.sorted())
    }

    public var areLettersSorted: Bool {
        guard let firstCh = first else { return true }

        var prevCh = firstCh
        for ch in self {
            guard prevCh <= ch else { return false }
            prevCh = ch
        }
        return true
    }
    
    public func assertSorted() {
        assert(self.areLettersSorted)
    }
    
    // isSortedSubset(of:) - all characters exist in other
    // assumes sorted strings as input
    public func isSortedSubset<S: StringProtocol>(of other: S) -> Bool {
        self.assertSorted()
        other.assertSorted()
        
        var selfIt = makeIterator()
        var otherIt = other.makeIterator()
        
        var s = selfIt.next()
        var o = otherIt.next()
        
        while s != nil, o != nil {
            guard s! >= o! else { return false }
            
            if s! == o! {
                s = selfIt.next()
                o = otherIt.next()
            } else {
                o = otherIt.next()
            }
        }
        
        return s == nil
    }
}
