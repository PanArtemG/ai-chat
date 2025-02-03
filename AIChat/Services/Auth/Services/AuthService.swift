//
//  AuthService.swift
//  AIChat
//
//  Created by Artem Panasenko on 03.02.2025.
//

protocol AuthService: Sendable {
    func getAuthenticatedUser() -> UserAuthInfo?
    func signInAnonymously() async throws -> (user: UserAuthInfo, isNewUser: Bool)
    func signInApple() async throws -> (user: UserAuthInfo, isNewUser: Bool)
    func signOut() throws
    func deleteAccount() async throws
}
