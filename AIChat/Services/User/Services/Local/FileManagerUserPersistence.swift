//
//  FileManagerUserPersistence.swift
//  AIChat
//
//  Created by Artem Panasenko on 12.04.2025.
//

import Foundation

struct FileManagerUserPersistence: LocalUserPersistenceProtocol {
    private let userDocumentKey = "current_user"
    func getCurrentUser() -> UserModel? {
        try? FileManager.getDocument(key: userDocumentKey)
    }
    
    func saveCurrentUser(_ user: UserModel?) throws {
        try FileManager.saveDocument(key: userDocumentKey, value: user)
    }
}
