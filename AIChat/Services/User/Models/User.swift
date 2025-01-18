//
//  User.swift
//  AIChat
//
//  Created by Artem Panasenko on 17.01.2025.
//

import SwiftUI

/// A model representing a user in the application.
struct User {
    /// A unique identifier for the user.
    let id: String
    
    /// The timestamp indicating when the user account was created, if available.
    let createdAt: Date?
    
    /// The timestamp indicating when the user account was last updated, if available.
    let updatedAt: Date?
    
    /// A boolean flag indicating whether the user has completed the onboarding process, if available.
    let completeOnboarding: Bool?
    
    /// A hexadecimal string representing the user's profile color, if available.
    let profileColorHex: String?
    
    /// Initializes a new `User` instance.
    ///
    /// - Parameters:
    ///   - id: A unique identifier for the user. (Required)
    ///   - createdAt: The timestamp indicating when the user account was created, if available. (Optional, defaults to `nil`)
    ///   - updatedAt: The timestamp indicating when the user account was last updated, if available. (Optional, defaults to `nil`)
    ///   - completeOnboarding: A boolean flag indicating if the user has completed onboarding, if available. (Optional, defaults to `nil`)
    ///   - profileColorHex: A hexadecimal string representing the user's profile color, if available. (Optional, defaults to `nil`)
    init(
        id: String,
        createdAt: Date? = nil,
        updatedAt: Date? = nil,
        completeOnboarding: Bool? = nil,
        profileColorHex: String? = nil
    ) {
        self.id = id
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.completeOnboarding = completeOnboarding
        self.profileColorHex = profileColorHex
    }
    
    /// The user's profile color as a `Color` instance.
    ///
    /// This computed property attempts to convert the `profileColorHex` value into a `Color` using a hex string initializer.
    /// If the `profileColorHex` is `nil` or invalid, it defaults to the system accent color.
    var profileColor: Color? {
        guard let profileColorHex else {
            return .accent
        }
        
        return Color(hex: profileColorHex)
    }
}
