//
//  Avatar.swift
//  AIChat
//
//  Created by Artem Panasenko on 07.01.2025.
//

import Foundation
import IdentifiableByString

/// A model representing an avatar with various customizable options, metadata, and a descriptive summary.
struct Avatar: Hashable, Codable, StringIdentifiable {
    
    /// A unique identifier for the avatar.
    let id: String
    
    /// The name of the avatar, if available.
    let name: String?
    
    /// The character option associated with the avatar, if specified.
    let characterOption: CharacterOption?
    
    /// The current action being performed by the avatar, if specified.
    let characterAction: CharacterAction?
    
    /// The location associated with the avatar, if specified.
    let characterLocation: CharacterLocation?
    
    /// The URL of the avatar's profile image, if provided.
    private(set) var profileImageUrl: String?
    
    /// The unique identifier of the author who created the avatar, if available.
    let authorId: String?
    
    /// The timestamp indicating when the avatar was created, if available.
    let createdAt: Date?
    
    /// The timestamp indicating the last time the avatar was updated, if available.
    let updatedAt: Date?
    
    /// A descriptive summary of the avatar, generated dynamically.
    ///
    /// This property uses `AvatarDescriptionBuilder` to generate a detailed description based on the avatar's properties.
    var characteDescription: String {
        AvatarDescriptionBuilder(avatar: self).characterDescription
    }
    
    mutating func updateProfileImageUrl(_ urlString: String) {
        profileImageUrl = urlString
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case characterOption = "character_option"
        case characterAction = "character_action"
        case characterLocation = "character_location"
        case profileImageUrl = "profile_image_url"
        case authorId = "author_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    /// Initializes a new `Avatar` instance.
    ///
    /// - Parameters:
    ///   - id: A unique identifier for the avatar. (Required)
    ///   - name: The name of the avatar, if available. (Optional, defaults to `nil`)
    ///   - characterOption: The character option associated with the avatar, if specified. (Optional, defaults to `nil`)
    ///   - characterAction: The current action being performed by the avatar, if specified. (Optional, defaults to `nil`)
    ///   - characterLocation: The location associated with the avatar, if specified. (Optional, defaults to `nil`)
    ///   - profileImageUrl: The URL of the avatar's profile image, if provided. (Optional, defaults to `nil`)
    ///   - authorId: The unique identifier of the author who created the avatar, if available. (Optional, defaults to `nil`)
    ///   - createdAt: The timestamp indicating when the avatar was created, if available. (Optional, defaults to `nil`)
    ///   - updatedAt: The timestamp indicating the last time the avatar was updated, if available. (Optional, defaults to `nil`)
    init(
        id: String = UUID().uuidString,
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
