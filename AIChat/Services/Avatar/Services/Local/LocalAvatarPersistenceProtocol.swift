//
//  LocalAvatarPersistenceProtocol.swift
//  AIChat
//
//  Created by Artem Panasenko on 04.05.2025.
//

@MainActor
protocol LocalAvatarPersistenceProtocol {
    func addRecentAvatar(_ avatar: Avatar) throws
    func getRecentAvatars() throws -> [Avatar]
}
