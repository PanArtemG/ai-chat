//
//  RemoteUserServiceProtocol.swift
//  AIChat
//
//  Created by Artem Panasenko on 12.04.2025.
//

import FirebaseFirestore

protocol RemoteUserServiceProtocol: Sendable {
    func saveUser(_ user: UserModel) async throws
    func markOnboardingComplete(for userId: String, profileColorHex: String) async throws
    func streamUser(userId: String, onListenerConfigured: @escaping (ListenerRegistration) -> Void) -> AsyncThrowingStream<UserModel, Error>
    func deleteUser(userId: String) async throws
}
