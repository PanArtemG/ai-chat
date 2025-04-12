//
//  MockUserServices.swift
//  AIChat
//
//  Created by Artem Panasenko on 12.04.2025.
//

struct MockUserServices: UserServicesProtocol {
    let remote: RemoteUserServiceProtocol
    let local: LocalUserPersistenceProtocol
    
    init(user: UserModel? = nil) {
        remote = MockUserService(user: user)
        local = MockUserPersistence(user: user)
    }
}
