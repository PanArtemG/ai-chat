//
//  RemoteAvatarServiceProtocol.swift
//  AIChat
//
//  Created by Artem Panasenko on 04.05.2025.
//

import SwiftUI

protocol RemoteAvatarServiceProtocol: Sendable {
    func create(_ avatar: Avatar, image: UIImage) async throws
    func getAvatar(id: String) async throws -> Avatar
    func getFeaturedAvatars() async throws -> [Avatar]
    func getPopularAvatars() async throws -> [Avatar]
    func getAvatarsForCategory(category: CharacterOption) async throws -> [Avatar]
    func getAvatarsForUser(userId: String) async throws -> [Avatar]
}
