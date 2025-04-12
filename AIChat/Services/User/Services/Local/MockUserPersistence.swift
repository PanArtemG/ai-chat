//
//  MockUserPersistence.swift
//  AIChat
//
//  Created by Artem Panasenko on 12.04.2025.
//

struct MockUserPersistence: LocalUserPersistenceProtocol {
    let currentUser: UserModel?
    
    init(user: UserModel? = nil) {
        currentUser = user
    }
    
    func getCurrentUser() -> UserModel? {
        currentUser
    }
    
    func saveCurrentUser(_ user: UserModel?) throws {
    }
}
