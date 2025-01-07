//
//  AvatarModel+Mocks.swift
//  AIChat
//
//  Created by Artem Panasenko on 07.01.2025.
//

import Foundation

extension AvatarModel {
    // MARK: - Mocks
    static var mock: AvatarModel {
        mocks[0]
    }
    
    static var mocks: [AvatarModel] {
        [
            .init(
                id: UUID().uuidString,
                name: "Leonard",
                characterOption: .cat,
                characterAction: .sleeping,
                characterLocation: .museum,
                profileImageUrl: Constants.randomImageUrl,
                authorId: UUID().uuidString,
                createdAt: .now,
                updatedAt: .now),
            .init(
                id: UUID().uuidString,
                name: "Alph",
                characterOption: .alien,
                characterAction: .eating,
                characterLocation: .space,
                profileImageUrl: Constants.randomImageUrl,
                authorId: UUID().uuidString,
                createdAt: .now,
                updatedAt: .now),
            .init(
                id: UUID().uuidString,
                name: "Alpha",
                characterOption: .woman,
                characterAction: .smiling,
                characterLocation: .party,
                profileImageUrl: Constants.randomImageUrl,
                authorId: UUID().uuidString,
                createdAt: .now,
                updatedAt: .now)
        ]
    }
}
