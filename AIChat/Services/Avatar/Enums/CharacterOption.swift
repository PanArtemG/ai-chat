//
//  CharacterOption.swift
//  AIChat
//
//  Created by Artem Panasenko on 07.01.2025.
//

import Foundation

enum CharacterOption: String {
    case man, woman, child, dog, cat, ant, alien
    
    static var `default`: Self {
        .ant
    }
}
