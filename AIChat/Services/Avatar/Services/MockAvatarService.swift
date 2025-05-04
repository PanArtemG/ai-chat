//
//  MockAvatarService.swift
//  AIChat
//
//  Created by Artem Panasenko on 04.05.2025.
//

import SwiftUI

struct MockAvatarService: AvatarServiceProtocol {
    func create(_ avatar: Avatar, image: UIImage) async throws {
    }
    func getFeaturedAvatars() async throws -> [Avatar] {
        try await Task.sleep(for: .seconds(2))
        return Avatar.mocks.shuffled()
    }
    
    func getPopularAvatars() async throws -> [Avatar] {
        try await Task.sleep(for: .seconds(2))
        return Avatar.mocks.shuffled()
    }
    
    func getAvatarsForCategory(category: CharacterOption) async throws -> [Avatar] {
        try await Task.sleep(for: .seconds(2))
        return Avatar.mocks.filter { $0.characterOption == category }
    }
    func getAvatarsForUser(userId: String) async throws -> [Avatar] {
        try await Task.sleep(for: .seconds(2))
        return Avatar.mocks.shuffled()
    }
}
