//
//  UserModel.swift
//  AIChat
//
//  Created by Artem Panasenko on 17.01.2025.
//

import SwiftUI
import IdentifiableByString

/// A model representing a user in the application.
struct UserModel: Codable, StringIdentifiable {
    /// A unique identifier for the user.
    let id: String
    
    /// The email address of the user, if available.
    let email: String?
    
    /// A boolean value indicating whether the user is signed in anonymously.
    let isAnonymous: Bool?
    
    /// The date and time when the user last signed in, if available.
    let lastSignInDate: Date?
    
    /// A boolean flag indicating whether the user has completed the onboarding process, if available.
    let completeOnboarding: Bool?
    
    /// A hexadecimal string representing the user's profile color, if available.
    let profileColorHex: String?
    
    /// The timestamp indicating when the user account was created, if available.
    let createdAt: Date?
    
    /// The timestamp indicating when the user account was last updated, if available.
    let updatedAt: Date?
    
    /// The timestamp indicating when version did updated.
    let creationVersion: String?
    
    /// Initializes a new `UserModel` instance.
    init(
        id: String,
        email: String? = nil,
        isAnonymous: Bool? = nil,
        lastSignInDate: Date? = nil,
        completeOnboarding: Bool? = nil,
        profileColorHex: String? = nil,
        createdAt: Date? = nil,
        updatedAt: Date? = nil,
        creationVersion: String? = nil
    ) {
        self.id = id
        self.email = email
        self.isAnonymous = isAnonymous
        self.lastSignInDate = lastSignInDate
        self.completeOnboarding = completeOnboarding
        self.profileColorHex = profileColorHex
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.creationVersion = creationVersion
    }
    
    /// Initializes a new `UserModel` instance from `UserAuthInfo`.
    init(auth: UserAuthInfo, creationVersion: String? = nil) {
        self.init(
            id: auth.uid,
            email: auth.email,
            isAnonymous: auth.isAnonymous,
            lastSignInDate: auth.lastSignInDate,
            createdAt: auth.creationDate,
            creationVersion: creationVersion
        )
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case isAnonymous = "is_anonymous"
        case lastSignInDate = "last_sign_in_date"
        case completeOnboarding = "complete_onboarding"
        case profileColorHex = "profile_color_hex"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case creationVersion = "creation_version"
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
