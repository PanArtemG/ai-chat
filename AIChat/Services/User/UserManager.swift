//
//  UserManager.swift
//  AIChat
//
//  Created by Artem Panasenko on 20.02.2025.
//

import FirebaseFirestore
import SwiftUI

@MainActor
@Observable
class UserManager {
    
    private let remoteService: RemoteUserServiceProtocol
    
    private let localStore: LocalUserPersistenceProtocol
    
    private(set) var currentUser: UserModel?
    
    private var currentUserListener: ListenerRegistration?
    
    init(services: UserServicesProtocol) {
        self.remoteService = services.remote
        self.localStore = services.local
        self.currentUser = localStore.getCurrentUser()
    }
    
    func logIn(auth: UserAuthInfo, isNewUser: Bool) async throws {
        let creationVersion = isNewUser ? Utilities.appVersion : nil
        let user = UserModel(auth: auth, creationVersion: creationVersion)
        
        try await remoteService.saveUser(user)
        addCurrentUserListener(userId: auth.uid)
    }
    
    func markOnboardingCompleteForCurrentUser(profileColorHex: String) async throws {
        let userId = try currentUserId()
        try await remoteService.markOnboardingComplete(for: userId, profileColorHex: profileColorHex)
    }
    
    func signOut() {
        currentUserListener?.remove()
        currentUserListener = nil
        currentUser = nil
    }
    
    func deleteCurrentUser() async throws {
        let userId = try currentUserId()
        try await remoteService.deleteUser(userId: userId)
        
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
                for try await user in remoteService.streamUser(userId: userId, onListenerConfigured: { listener in
                    self.currentUserListener = listener
                }) {
                    currentUser = user
                    saveCurrentUserLocally()
                    print("Successfully listened to user: \(user.id)")
                }
            } catch {
                print("Error attaching user listener: \(error)")
            }
        }
    }
    
    private func saveCurrentUserLocally()  {
        do {
            try localStore.saveCurrentUser(currentUser)
            print("Success saved current user locally")
        } catch {
            print("Error saving current user locally: \(error)")
        }
    }
    
    enum UserManagerError: LocalizedError {
        case noUserId
    }
}
