//
//  Collection+Extensions.swift
//  AIChat
//
//  Created by Artem Panasenko on 04.05.2025.
//

import Foundation

extension Collection {
    func first(upTo value: Int) -> [Element]? {
        guard !isEmpty else {
            return nil
        }
        
        let maxItems = Swift.min(count, value)
        return Array(prefix(maxItems))
    }
    
    func last(upTo value: Int) -> [Element]? {
        guard !isEmpty else {
            return nil
        }
        
        let maxItems = Swift.min(count, value)
        return Array(suffix(maxItems))
    }
}
