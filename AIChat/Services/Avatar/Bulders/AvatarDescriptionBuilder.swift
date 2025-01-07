//
//  AvatarDescriptionBuilder.swift
//  AIChat
//
//  Created by Artem Panasenko on 07.01.2025.
//

struct AvatarDescriptionBuilder {
    /// An Avatar character option as `CharacterOption`
    let characterOption: CharacterOption
    
    /// An Avatar character action as `CharacterAction`
    let characterAction: CharacterAction
    
    /// An Avatar character location as `CharacterAction`
    let  characterLocation: CharacterLocation
    
    /// Initialize from values
    /// - Parameters:
    ///   - characterOption:as `CharacterOption`
    ///   - characterAction: as `CharacterAction`
    ///   - characterLocation: as `CharacterLocation`
    init(
        _ characterOption: CharacterOption? = nil,
        _ characterAction: CharacterAction? = nil,
        _ characterLocation: CharacterLocation? = nil
    ) {
        self.characterOption = characterOption ?? .default
        self.characterAction = characterAction ?? .default
        self.characterLocation = characterLocation ?? .default
    }
    
    /// Initialize from model `AvatarModel`
    /// - Parameter avatar: as `AvatarModel`
    init (avatar: AvatarModel) {
        self.characterOption = avatar.characterOption ?? .default
        self.characterAction = avatar.characterAction ?? .default
        self.characterLocation = avatar.characterLocation ?? .default
    }
    
    /// Build description for  an`Avatar`
    var characterDescription: String {
        "A \(characterOption.rawValue) that is \(characterAction.rawValue) in the \(characterLocation.rawValue)"
    }
}
