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
    private let remote: RemoteAvatarServiceProtocol 
    private let local: LocalAvatarPersistenceProtocol
    
    init(
        remote: RemoteAvatarServiceProtocol,
        local: LocalAvatarPersistenceProtocol
    ) {
        self.remote = remote
        self.local = local
    }
    
    func addRecentAvatar(_ avatar: Avatar) throws {
        try local.addRecentAvatar(avatar)
    }
    
    func getRecentAvatars() throws -> [Avatar] {
        try local.getRecentAvatars()
    }
    
    func create(_ avatar: Avatar, image: UIImage) async throws {
        try await remote.create(avatar, image: image)
    }
    
    func getAvatar(id: String) async throws -> Avatar {
        try await remote.getAvatar(id: id)
    }
    
    func getFeaturedAvatars() async throws -> [Avatar] {
        try await remote.getFeaturedAvatars()
    }
    
    func getPopularAvatars() async throws -> [Avatar] {
        try await remote.getPopularAvatars()
    }
    
    func getAvatarsForCategory(category: CharacterOption) async throws -> [Avatar] {
        try await remote.getAvatarsForCategory(category: category)
    }
    
    func getAvatarsForUser(userId: String) async throws -> [Avatar] {
        try await remote.getAvatarsForUser(userId: userId)
    }
}
