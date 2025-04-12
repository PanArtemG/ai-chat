//
//  UserServicesProtocol.swift
//  AIChat
//
//  Created by Artem Panasenko on 12.04.2025.
//

protocol UserServicesProtocol {
    var remote: RemoteUserServiceProtocol { get }
    var local: LocalUserPersistenceProtocol { get }
}
