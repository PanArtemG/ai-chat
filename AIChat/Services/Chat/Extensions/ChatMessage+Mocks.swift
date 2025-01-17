//
//  ChatMessage+Mocks.swift
//  AIChat
//
//  Created by Artem Panasenko on 17.01.2025.
//

import Foundation

extension ChatMessage {
    // MARK: - Mocks
    static var mock: Self {
        mocks[0]
    }
    
    static var mocks: [Self] {
        [
            ChatMessage(
                id: UUID().uuidString,
                chatId: "chat1",
                authorId: "user1",
                content: "Hello, how are you?",
                seenById: ["user2", "user3"],
                createdAt: Date().addingTimeInterval(days: -1, hours: -2),
                updatedAt: Date().addingTimeInterval(days: -1, hours: -1)
            ),
            ChatMessage(
                id: UUID().uuidString,
                chatId: "chat1",
                authorId: "user2",
                content: "I'm good, thanks! How about you?",
                seenById: ["user1", "user3"],
                createdAt: Date().addingTimeInterval(hours: -23),
                updatedAt: Date().addingTimeInterval(hours: -22)
            ),
            ChatMessage(
                id: UUID().uuidString,
                chatId: "chat1",
                authorId: "user1",
                content: "I'm doing great, thanks for asking!",
                seenById: ["user2"],
                createdAt: Date().addingTimeInterval(hours: -22, minutes: -30),
                updatedAt: Date().addingTimeInterval(hours: -22)
            ),
            ChatMessage(
                id: UUID().uuidString,
                chatId: "chat1",
                authorId: "user3",
                content: "That's great to hear! What's new?",
                seenById: ["user1", "user2"],
                createdAt: Date().addingTimeInterval(hours: -20),
                updatedAt: Date().addingTimeInterval(hours: -19)
            )
        ]
    }
}
