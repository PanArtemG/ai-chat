//
//  CharacterLocation.swift
//  AIChat
//
//  Created by Artem Panasenko on 07.01.2025.
//

import Foundation

enum CharacterLocation: String {
    case party, office, museum, city, forest, space, desert, mall
    
    static var `default`: Self {
        .desert
    }
}
