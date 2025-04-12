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
                completeOnboarding: true,
                profileColorHex: "#FF5733", // Orange-red
                createdAt: Date().addingTimeInterval(days: -30),
                updatedAt: Date().addingTimeInterval(days: -1)
            ),
            UserModel(
                id: "user2",
                completeOnboarding: false,
                profileColorHex: "#33FF57", // Green
                createdAt: Date().addingTimeInterval(days: -60),
                updatedAt: Date().addingTimeInterval(days: -7)
            ),
            UserModel(
                id: "user3",
                completeOnboarding: true,
                profileColorHex: "#3357FF", // Blue
                createdAt: Date().addingTimeInterval(days: -15),
                updatedAt: Date().addingTimeInterval(days: -2)
            ),
            UserModel(
                id: "user4",
                completeOnboarding: false,
                profileColorHex: "#FF33A1", // Pink
                createdAt: Date().addingTimeInterval(days: -90),
                updatedAt: Date().addingTimeInterval(days: -10)
            )
        ]
    }
}
