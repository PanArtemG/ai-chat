//
//  FirebaseAvatarService.swift
//  AIChat
//
//  Created by Artem Panasenko on 04.05.2025.
//

import FirebaseFirestore
import SwiftfulFirestore

struct FirebaseAvatarService: RemoteAvatarServiceProtocol {
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
    
    func getAvatar(id: String) async throws -> Avatar {
        try await collection.getDocument(id: id)
    }
    
    func getFeaturedAvatars() async throws -> [Avatar] {
        try await collection
            .limit(to: 50)
            .getAllDocuments()
            .shuffled()
            .first(upTo: 5) ?? []
    }
    
    func getPopularAvatars() async throws -> [Avatar] {
        try await collection
            .limit(to: 50)
            .getAllDocuments()
    }
    
    func getAvatarsForCategory(category: CharacterOption) async throws -> [Avatar] {
        try await collection
            .whereField(Avatar.CodingKeys.characterOption.rawValue, isEqualTo: category.rawValue)
            .limit(to: 50)
            .getAllDocuments()
    }
    
    func getAvatarsForUser(userId: String) async throws -> [Avatar] {
        try await collection
            .whereField(Avatar.CodingKeys.authorId.rawValue, isEqualTo: userId)
            .getAllDocuments()
    }
}
