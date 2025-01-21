//
//  TextValidationHelper.swift
//  AIChat
//
//  Created by Artem Panasenko on 21.01.2025.
//

import Foundation

struct TextValidationHelper {
    
    static func checkIfTextIsValid(text: String) throws {
        let minCount = 3
        guard text.count >= minCount else {
            throw TextValidationError.notEnoughCharacters(min: minCount)
        }
        
        let badWords: [String] = [
            "shit", "bitch", "ass"
        ]
        
        guard !badWords.contains(text.lowercased()) else {
            throw TextValidationError.hasBadWords
        }
    }
    
    enum TextValidationError: LocalizedError {
        case notEnoughCharacters(min: Int)
        case hasBadWords
        
        var errorDescription: String? {
            switch self {
            case .notEnoughCharacters(min: let min):
                return "Pleas add at least \(min) characters."
            case .hasBadWords:
                return "Message contains bad words"
            }
        }
    }
}
