//
//  ProductionUserServices.swift
//  AIChat
//
//  Created by Artem Panasenko on 12.04.2025.
//

struct ProductionUserServices: UserServicesProtocol {
    let remote: RemoteUserServiceProtocol = FirebaseUserService()
    let local: LocalUserPersistenceProtocol = FileManagerUserPersistence()
}
