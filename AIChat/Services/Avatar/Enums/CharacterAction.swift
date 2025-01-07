//
//  CharacterAction.swift
//  AIChat
//
//  Created by Artem Panasenko on 07.01.2025.
//

import Foundation

enum CharacterAction: String {
    case smiling, sitting, standing, walking, sleeping, eating, drinking
    
    static var `default`: Self {
        .drinking
    }
}
