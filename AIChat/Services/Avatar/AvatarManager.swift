//
//  AvatarManager.swift
//  AIChat
//
//  Created by Artem Panasenko on 20.04.2025.
//

import SwiftUI

@MainActor
@Observable
class AvatarManager {
    private let service: AvatarServiceProtocol
    
    init(service: AvatarServiceProtocol) {
        self.service = service
    }
    
    func create(_ avatar: Avatar, image: UIImage) async throws {
        try await service.create(avatar, image: image)
    }
    
    func getFeaturedAvatars() async throws -> [Avatar] {
        try await service.getFeaturedAvatars()
    }
    
    func getPopularAvatars() async throws -> [Avatar] {
        try await service.getPopularAvatars()
    }
    
    func getAvatarsForCategory(category: CharacterOption) async throws -> [Avatar] {
        try await service.getAvatarsForCategory(category: category)
    }
    
    func getAvatarsForUser(userId: String) async throws -> [Avatar] {
        try await service.getAvatarsForUser(userId: userId)
    }
}
