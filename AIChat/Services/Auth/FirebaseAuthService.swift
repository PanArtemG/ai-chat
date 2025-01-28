//
//  FirebaseAuthService.swift
//  AIChat
//
//  Created by Artem Panasenko on 28.01.2025.
//

import FirebaseAuth

struct FirebaseAuthService {
    
    func getAuthenticatedUser() -> UserAuthInfo? {
        guard let user = Auth.auth().currentUser else {
            return nil
        }
        
        return UserAuthInfo(user: user)
    }
    
    func signInAnonymously() async throws -> (user: UserAuthInfo, isNewUser: Bool) {
        let result = try await Auth.auth().signInAnonymously()
        let user = UserAuthInfo(user: result.user)
        let isNewUser = result.additionalUserInfo?.isNewUser ?? true
        return (user, isNewUser)
    }
}
