//
//  MockLocalAvatarPersistence.swift
//  AIChat
//
//  Created by Artem Panasenko on 04.05.2025.
//

@MainActor
struct MockLocalAvatarPersistence: LocalAvatarPersistenceProtocol {
    func addRecentAvatar(_ avatar: Avatar) throws {
        
    }
    
    func getRecentAvatars() throws -> [Avatar] {
        Avatar.mocks.shuffled()
    }
}
