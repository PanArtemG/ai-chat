//
//  FirebaseUserService.swift
//  AIChat
//
//  Created by Artem Panasenko on 12.04.2025.
//

import FirebaseFirestore
import SwiftfulFirestore

typealias ListListenerRegistration = FirebaseFirestore.ListenerRegistration

struct FirebaseUserService: RemoteUserServiceProtocol {
    var collection: CollectionReference {
        Firestore.firestore().collection("users")
    }
    
    func saveUser(_ user: UserModel) async throws {
//        try await collection.document(user.id).setData(from: user, merge: true)
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
