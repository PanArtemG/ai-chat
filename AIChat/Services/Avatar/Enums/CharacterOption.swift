//
//  CharacterOption.swift
//  AIChat
//
//  Created by Artem Panasenko on 07.01.2025.
//

import Foundation

enum CharacterOption: String, CaseIterable, Hashable {
    case man
    case woman
    case child
    case dog
    case cat
    case ant
    case alien
    
    static var `default`: Self {
        .ant
    }
}