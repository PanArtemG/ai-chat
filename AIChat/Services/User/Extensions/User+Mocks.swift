//
//  UserModel+Mocks.swift
//  AIChat
//
//  Created by Artem Panasenko on 17.01.2025.
//

import Foundation

extension UserModel {
    // MARK: - Mocks
    static var mock: Self {
        mocks[0]
    }
    
    static var mocks: [Self] {
        [
            UserModel(
                id: "user1",
                createdAt: Date().addingTimeInterval(days: -30),
                updatedAt: Date().addingTimeInterval(days: -1),
                completeOnboarding: true,
                profileColorHex: "#FF5733" // Orange-red
            ),
            UserModel(
                id: "user2",
                createdAt: Date().addingTimeInterval(days: -60),
                updatedAt: Date().addingTimeInterval(days: -7),
                completeOnboarding: false,
                profileColorHex: "#33FF57" // Green
            ),
            UserModel(
                id: "user3",
                createdAt: Date().addingTimeInterval(days: -15),
                updatedAt: Date().addingTimeInterval(days: -2),
                completeOnboarding: true,
                profileColorHex: "#3357FF" // Blue
            ),
            UserModel(
                id: "user4",
                createdAt: Date().addingTimeInterval(days: -90),
                updatedAt: Date().addingTimeInterval(days: -10),
                completeOnboarding: false,
                profileColorHex: "#FF33A1" // Pink
            )
        ]
    }
}
