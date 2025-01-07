//
//  AvatarModel.swift
//  AIChat
//
//  Created by Artem Panasenko on 07.01.2025.
//

import Foundation

/// Model use for representation `Avatar`
struct AvatarModel {
    /// A model identifier
    let id: String
    
    /// An Avatar name as `Optional<String>`
    let name: String?
    
    /// An Avatar character option as `Optional<CharacterOption>`
    let characterOption: CharacterOption?
    
    /// An Avatar character action as `Optional<CharacterAction>`
    let characterAction: CharacterAction?
    
    /// An Avatar character location as `Optional<CharacterAction>`
    let characterLocation: CharacterLocation?
    
    /// An Avatar profile image name as `Optional<String>`
    let profileImageUrl: String?
    
    /// An Avatar author id as `Optional<String>`
    let authorId: String?
    
    /// A Date of created as `Optional<Date>`
    let createdAt: Date?
    
    /// A Date of updated as `Optional<Date>`
    let updatedAt: Date?
    
    /// An Avatar description as `String`
    var characteDescription: String {
        AvatarDescriptionBuilder(avatar: self).characterDescription
    }
    
    init(
        id: String,
        name: String? = nil,
        characterOption: CharacterOption? = nil,
        characterAction: CharacterAction? = nil,
        characterLocation: CharacterLocation? = nil,
        profileImageUrl: String? = nil,
        authorId: String? = nil,
        createdAt: Date? = nil,
        updatedAt: Date? = nil
    ) {
        self.id = id
        self.name = name
        self.characterOption = characterOption
        self.characterAction = characterAction
        self.characterLocation = characterLocation
        self.profileImageUrl = profileImageUrl
        self.authorId = authorId
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
