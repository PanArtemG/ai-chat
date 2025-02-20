//
//  AuthDataResult+Extensions.swift
//  AIChat
//
//  Created by Artem Panasenko on 01.02.2025.
//

import FirebaseAuth

extension AuthDataResult {
    var asAuthInfo: (user: UserAuthInfo, isNewUser: Bool) {
        let user = UserAuthInfo(user: user)
        let isNewUser = additionalUserInfo?.isNewUser ?? true
        return (user, isNewUser)
    }
}
