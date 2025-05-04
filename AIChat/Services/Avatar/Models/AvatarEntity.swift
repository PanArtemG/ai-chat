//
//  AvatarEntity.swift
//  AIChat
//
//  Created by Artem Panasenko on 04.05.2025.
//

import Foundation
import SwiftData

@Model
class AvatarEntity {
    /// A unique identifier for the avatar.
    @Attribute(.unique) var id: String
    
    /// The name of the avatar, if available.
    var name: String?
    
    /// The character option associated with the avatar, if specified.
    var characterOption: CharacterOption?
    
    /// The current action being performed by the avatar, if specified.
    var characterAction: CharacterAction?
    
    /// The location associated with the avatar, if specified.
    var characterLocation: CharacterLocation?
    
    /// The URL of the avatar's profile image, if provided.
    var profileImageUrl: String?
    
    /// The unique identifier of the author who created the avatar, if available.
    var authorId: String?
    
    /// The timestamp indicating when the avatar was created, if available.
    var createdAt: Date?
    
    /// The timestamp indicating the last time the avatar was updated, if available.
    var updatedAt: Date?
    
    var addedAt: Date?
    
    init(from model: Avatar) {
        self.id = model.id
        self.name = model.name
        self.characterOption = model.characterOption
        self.characterAction = model.characterAction
        self.characterLocation = model.characterLocation
        self.profileImageUrl = model.profileImageUrl
        self.authorId = model.authorId
        self.createdAt = model.createdAt
        self.updatedAt = model.updatedAt
        self.addedAt = .now
    }
    
    func toModel() -> Avatar {
        Avatar(
            id: id,
            name: name,
            characterOption: characterOption,
            characterAction: characterAction,
            characterLocation: characterLocation,
            profileImageUrl: profileImageUrl,
            authorId: authorId,
            createdAt: createdAt
        )
    }
}
