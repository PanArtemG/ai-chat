//
//  AvatarManager.swift
//  AIChat
//
//  Created by Artem Panasenko on 20.04.2025.
//

protocol AvatarManagerProtocol {
    
}
protocol AvatarServiceProtocol: Sendable {
    func create(_ avatar: Avatar, image: UIImage) async throws
}

struct MockAvatarService: AvatarServiceProtocol {
    func create(_ avatar: Avatar, image: UIImage) async throws {
        
    }
}
import FirebaseFirestore
import SwiftfulFirestore

struct FirebaseAvatarService: AvatarServiceProtocol {

    
    var collection: CollectionReference {
        Firestore.firestore().collection(rootPath)
    }
    
    private let rootPath = "avatars"
    
    func create(_ avatar: Avatar, image: UIImage) async throws {
        // Upload image
        let path = "\(rootPath)/\(avatar.id)"
        let url = try await FirebaseImageUploadService().upload(image, path: path)
        
        // Update avatar image
        var avatar = avatar
        avatar.updateProfileImageUrl(url.absoluteString)
        
        // Upload the avatar
        try collection.document(avatar.id).setData(from: avatar, merge: true)
    }
}

import SwiftUI

@MainActor
@Observable
class AvatarManager: AvatarManagerProtocol {
    
    private let service: AvatarServiceProtocol
    
    private var listener: (any NSObjectProtocol)?
    
    init(service: AvatarServiceProtocol) {
        self.service = service
    }
    
    func create(_ avatar: Avatar, image: UIImage) async throws {
        try await service.create(avatar, image: image)
    }
    
}
