//
//  MockUserService.swift
//  AIChat
//
//  Created by Artem Panasenko on 12.04.2025.
//

import FirebaseFirestore

struct MockUserService: RemoteUserServiceProtocol {
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
