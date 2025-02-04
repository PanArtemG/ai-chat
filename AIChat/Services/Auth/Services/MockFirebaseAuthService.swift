//
//  MockFirebaseAuthService.swift
//  AIChat
//
//  Created by Artem Panasenko on 03.02.2025.
//

import Foundation

struct MockFirebaseAuthService: AuthService {
    let currentUser: UserAuthInfo?
    
    init(user: UserAuthInfo? = nil) {
        currentUser = user
    }
    
    func addAuthenticatedUserListener(onListenerAttached: (any NSObjectProtocol) -> Void) -> AsyncStream<UserAuthInfo?> {
        AsyncStream { continuation in
            continuation.yield(currentUser)
        }
    }
    
    func getAuthenticatedUser() -> UserAuthInfo? {
        currentUser
    }
    
    func signInAnonymously() async throws -> (user: UserAuthInfo, isNewUser: Bool) {
        let isNewUser: Bool = true
        let user = UserAuthInfo.mock(isAnonymous: isNewUser)
        return (user, isNewUser)
    }
    
    func signInApple() async throws -> (user: UserAuthInfo, isNewUser: Bool) {
        let isNewUser: Bool = false
        let user = UserAuthInfo.mock(isAnonymous: isNewUser)
        return (user, isNewUser)
    }
    
    func signOut() throws {
        
    }
    
    func deleteAccount() async throws {
        
    }
}
