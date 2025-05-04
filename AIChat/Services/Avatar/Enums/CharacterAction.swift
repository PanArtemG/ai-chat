//
//  CharacterAction.swift
//  AIChat
//
//  Created by Artem Panasenko on 07.01.2025.
//

import Foundation

enum CharacterAction: String, CaseIterable, Hashable, Codable {
    case smiling
    case sitting
    case standing
    case walking
    case sleeping
    case eating
    case drinking
    
    static var `default`: Self {
        .drinking
    }
}
