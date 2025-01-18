//
//  Chat+Mocks.swift
//  AIChat
//
//  Created by Artem Panasenko on 17.01.2025.
//

import Foundation

extension Chat {
    // MARK: - Mocks
    static var mock: Chat {
        mocks[0]
    }
    
    static var mocks: [Chat] {
        [
            Chat(
                id: UUID().uuidString,
                userId: UUID().uuidString,
                avatarId: UUID().uuidString,
                createdAt: Date(),
                updatedAt: Date()
            ),
            Chat(
                id: UUID().uuidString,
                userId: UUID().uuidString,
                avatarId: UUID().uuidString,
                createdAt: Date().addingTimeInterval(days: -1), // 1 day ago
                updatedAt: Date().addingTimeInterval(hours: -12) // 12 hours ago
            ),
            Chat(
                id: UUID().uuidString,
                userId: UUID().uuidString,
                avatarId: UUID().uuidString,
                createdAt: Date().addingTimeInterval(days: -7), // 1 week ago
                updatedAt: Date().addingTimeInterval(days: -3) // 3 days ago
            ),
            Chat(
                id: UUID().uuidString,
                userId: UUID().uuidString,
                avatarId: UUID().uuidString,
                createdAt: Date().addingTimeInterval(hours: -48), // 2 days ago
                updatedAt: Date().addingTimeInterval(minutes: -120) // 2 hours ago
            )
        ]
    }
}
