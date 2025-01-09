//
//  CharacterLocation.swift
//  AIChat
//
//  Created by Artem Panasenko on 07.01.2025.
//

import Foundation

enum CharacterLocation: String {
    case party
    case office
    case museum
    case city
    case forest
    case space
    case desert
    case mall
    
    static var `default`: Self {
        .desert
    }
}
