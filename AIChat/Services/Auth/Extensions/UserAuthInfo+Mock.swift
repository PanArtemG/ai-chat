//
//  UserAuthInfo+Mock.swift
//  AIChat
//
//  Created by Artem Panasenko on 03.02.2025.
//

import Foundation

extension UserAuthInfo {
    static func mock(isAnonymous: Bool = false) -> Self {
        UserAuthInfo(
            uid: "mock_user_1",
            email: "mail@mail.com",
            isAnonymous: isAnonymous,
            creationDate: .now,
            lastSignInDate: .now
        )
    }
}
