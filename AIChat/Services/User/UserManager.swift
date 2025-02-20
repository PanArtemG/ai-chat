//
//  UserManager.swift
//  AIChat
//
//  Created by Artem Panasenko on 20.02.2025.
//

import SwiftUI

protocol UserService: Sendable {
    func saveUser(_ user: UserModel) async throws
    func markOnboardingComplete(for userId: String, profileColorHex: String) async throws
    func streamUser(userId: String, onListenerConfigured: @escaping (ListenerRegistration) -> Void) -> AsyncThrowingStream<UserModel, Error>
    func deleteUser(userId: String) async throws
}

struct MockUserService: UserService {
    let currentUser: UserModel?
    
    init(user: UserModel? = nil) {
        currentUser = user
    }
    
    func saveUser(_ user: UserModel) async throws {

    }
    
    func markOnboardingComplete(for userId: String, profileColorHex: String) async throws {
        
    }
    
    func streamUser(userId: String, onListenerConfigured: @escaping (any ListenerRegistration) -> Void) -> AsyncThrowingStream<UserModel, any Error> {
        AsyncThrowingStream { continuation in
            if let currentUser {
                continuation.yield(currentUser)
            }
        }
    }
    
    func deleteUser(userId: String) async throws {
        
    }
}

import FirebaseFirestore
import SwiftfulFirestore

struct FirebaseUserService: UserService {
    var collection: CollectionReference {
        Firestore.firestore().collection("users")
    }
    
    func saveUser(_ user: UserModel) async throws {
        try await collection.setDocument(document: user)
    }
    
    func markOnboardingComplete(for userId: String, profileColorHex: String) async throws {
        try await collection.document(userId).updateData([
            UserModel.CodingKeys.completeOnboarding.rawValue: true,
            UserModel.CodingKeys.profileColorHex.rawValue: profileColorHex
        ])
    }
    
    func streamUser(userId: String, onListenerConfigured: @escaping (ListenerRegistration) -> Void) -> AsyncThrowingStream<UserModel, Error> {
        collection.streamDocument(id: userId)
    }
    
    func deleteUser(userId: String) async throws {
        try await collection.deleteDocument(id: userId)
    }
}

@MainActor
@Observable
class UserManager {
    
    private let service: UserService
    
    private(set) var currentUser: UserModel?
    
    private var currentUserListener: ListenerRegistration?
    
    init(service: UserService) {
        self.service = service
        self.currentUser = nil
    }
    
    func logIn(auth: UserAuthInfo, isNewUser: Bool) async throws {
        let creationVersion = isNewUser ? Utilities.appVersion : nil
        let user = UserModel(auth: auth, creationVersion: creationVersion)
        
        try await service.saveUser(user)
        addCurrentUserListener(userId: auth.uid)
    }
    
    func markOnboardingCompleteForCurrentUser(profileColorHex: String) async throws {
        let userId = try currentUserId()
        try await service.markOnboardingComplete(for: userId, profileColorHex: profileColorHex)
    }
    
    func signOut() {
        currentUserListener?.remove()
        currentUserListener = nil
        currentUser = nil
    }
    
    func deleteCurrentUser() async throws {
        let userId = try currentUserId()
        try await service.deleteUser(userId: userId)
        
        signOut()
    }
    
    private func currentUserId() throws -> String {
        guard let userId = currentUser?.id else {
            throw UserManagerError.noUserId
        }
        return userId
    }
    
    private func addCurrentUserListener(userId: String) {
        currentUserListener?.remove()
        
        Task {
            do {
                for try await value in service.streamUser(userId: userId, onListenerConfigured: { listener in
                    self.currentUserListener = listener
                }) {
                    self.currentUser = value
                    print("Successfully listened to user: \(value.id)")
                }
            } catch {
                print("Error attaching user listener: \(error)")
            }
        }
    }
    
    enum UserManagerError: LocalizedError {
        case noUserId
    }
}
