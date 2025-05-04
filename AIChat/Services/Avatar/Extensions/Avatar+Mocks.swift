//
//  Avatar+Mocks.swift
//  AIChat
//
//  Created by Artem Panasenko on 07.01.2025.
//

import Foundation

extension Avatar {
    // MARK: - Mocks
    static var mock: Self {
        mocks[0]
    }
    
    static var mocks: [Self] {
        [
            .init(
                id: "e7176418-f8cc-4a34-aacd-0197a6191e0b",
                name: "Leonard",
                characterOption: .cat,
                characterAction: .sleeping,
                characterLocation: .museum,
                profileImageUrl: Constants.randomImageUrl,
                authorId: UUID().uuidString,
                createdAt: .now,
                updatedAt: .now),
            .init(
                id: "8d5d924a-44fa-4d5f-ab7e-9e8a5a0cad7e",
                name: "Alpha",
                characterOption: .alien,
                characterAction: .eating,
                characterLocation: .space,
                profileImageUrl: Constants.randomImageUrl,
                authorId: UUID().uuidString,
                createdAt: .now,
                updatedAt: .now),
            .init(
                id: "fd2a1956-21a6-4d84-aaef-d04287678604",
                name: "Beta",
                characterOption: .woman,
                characterAction: .smiling,
                characterLocation: .party,
                profileImageUrl: Constants.randomImageUrl,
                authorId: UUID().uuidString,
                createdAt: .now,
                updatedAt: .now),
            .init(
                id: "157ec729-f437-49c8-8cbc-1cebc3bc86a6",
                name: "Gamma",
                characterOption: .dog,
                characterAction: .sitting,
                characterLocation: .city,
                profileImageUrl: Constants.randomImageUrl,
                authorId: UUID().uuidString,
                createdAt: .now,
                updatedAt: .now)
        ]
    }
}
