//
//  LocalUserPersistenceProtocol.swift
//  AIChat
//
//  Created by Artem Panasenko on 12.04.2025.
//

protocol LocalUserPersistenceProtocol {
    func getCurrentUser() -> UserModel?
    
    func saveCurrentUser(_ user: UserModel?) throws
}
