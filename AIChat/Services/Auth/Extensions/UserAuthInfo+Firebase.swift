//
//  UserAuthInfo+Firebase.swift
//  AIChat
//
//  Created by Artem Panasenko on 01.02.2025.
//

import FirebaseAuth

extension UserAuthInfo {
    
    /// Initializes a new instance of `UserAuthInfo` from a Firebase `User` object.
    ///
    /// - Parameter user: A Firebase `User` instance.
    /// - Extracts relevant user authentication data from the provided `User` object.
    internal init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.isAnonymous = user.isAnonymous
        self.creationDate = user.metadata.creationDate
        self.lastSignInDate = user.metadata.lastSignInDate
    }
}
