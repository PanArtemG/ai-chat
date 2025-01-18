//
//  Chat.swift
//  AIChat
//
//  Created by Artem Panasenko on 17.01.2025.
//

import Foundation

/// A model representing a chat instance, including metadata such as user and avatar IDs, and timestamps.
struct Chat: Identifiable {
    
    /// A unique identifier for the chat.
    let id: String
    
    /// The unique identifier of the user associated with the chat.
    let userId: String
    
    /// The identifier for the avatar associated with the chat.
    let avatarId: String
    
    /// The timestamp when the chat was created.
    let createdAt: Date
    
    /// The timestamp when the chat was last updated.
    let updatedAt: Date
    
    /// Initializes a new `Chat` instance.
    ///
    /// - Parameters:
    ///   - id: A unique identifier for the chat.
    ///   - userId: The unique identifier of the user associated with the chat.
    ///   - avatarId: The identifier for the avatar associated with the chat.
    ///   - createdAt: The timestamp when the chat was created.
    ///   - updatedAt: The timestamp when the chat was last updated.
    init(
        id: String,
        userId: String,
        avatarId: String,
        createdAt: Date,
        updatedAt: Date
    ) {
        self.id = id
        self.userId = userId
        self.avatarId = avatarId
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
