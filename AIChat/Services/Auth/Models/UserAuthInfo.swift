//
//  UserAuthInfo.swift
//  AIChat
//
//  Created by Artem Panasenko on 28.01.2025.
//

import SwiftUI

/// A structure representing user authentication information.
struct UserAuthInfo: Sendable {
    
    /// The unique identifier for the authenticated user.
    let uid: String
    
    /// The email address of the user, if available.
    let email: String?
    
    /// A boolean value indicating whether the user is signed in anonymously.
    let isAnonymous: Bool
    
    /// The date and time when the user's account was created, if available.
    let creationDate: Date?
    
    /// The date and time when the user last signed in, if available.
    let lastSignInDate: Date?
    
    /// Initializes a new instance of `UserAuthInfo`.
    ///
    /// - Parameters:
    ///   - uid: The unique identifier for the authenticated user. (Required)
    ///   - email: The email address of the user, if available. (Optional, defaults to `nil`)
    ///   - isAnonymous: A boolean indicating whether the user is signed in anonymously. (Optional, defaults to `false`)
    ///   - creationDate: The date and time when the user's account was created, if available. (Optional, defaults to `nil`)
    ///   - lastSignInDate: The date and time when the user last signed in, if available. (Optional, defaults to `nil`)
    internal init(
        uid: String,
        email: String? = nil,
        isAnonymous: Bool = false,
        creationDate: Date? = nil,
        lastSignInDate: Date? = nil
    ) {
        self.uid = uid
        self.email = email
        self.isAnonymous = isAnonymous
        self.creationDate = creationDate
        self.lastSignInDate = lastSignInDate
    }
}
