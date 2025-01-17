//
//  ChatMessage.swift
//  AIChat
//
//  Created by Artem Panasenko on 17.01.2025.
//

import Foundation

/// A model representing a chat message, including metadata about the message's content, author, and timestamps.
struct ChatMessage: Codable {
    
    /// A unique identifier for the message.
    let id: String
    
    /// The unique identifier of the chat the message belongs to.
    let chatId: String
    
    /// The unique identifier of the author who created the message, if available.
    let authorId: String?
    
    /// The textual content of the message, if provided.
    let content: String?
    
    /// A list of user identifiers representing users who have seen the message, if available.
    let seenById: [String]?
    
    /// The timestamp indicating when the message was created, if available.
    let createdAt: Date?
    
    /// The timestamp indicating when the message was last updated, if available.
    let updatedAt: Date?
    
    /// Initializes a new `ChatMessage` instance.
    ///
    /// - Parameters:
    ///   - id: A unique identifier for the message. (Required)
    ///   - chatId: The unique identifier of the chat the message belongs to. (Required)
    ///   - authorId: The unique identifier of the author who created the message, if available. (Optional, defaults to `nil`)
    ///   - content: The textual content of the message, if provided. (Optional, defaults to `nil`)
    ///   - seenById: A list of user identifiers representing users who have seen the message, if available. (Optional, defaults to `nil`)
    ///   - createdAt: The timestamp indicating when the message was created, if available. (Optional, defaults to `nil`)
    ///   - updatedAt: The timestamp indicating when the message was last updated, if available. (Optional, defaults to `nil`)
    init(
        id: String,
        chatId: String,
        authorId: String? = nil,
        content: String? = nil,
        seenById: [String]? = nil,
        createdAt: Date? = nil,
        updatedAt: Date? = nil
    ) {
        self.id = id
        self.chatId = chatId
        self.authorId = authorId
        self.content = content
        self.seenById = seenById
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
