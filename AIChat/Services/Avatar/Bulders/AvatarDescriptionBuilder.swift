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
    
    /// Initialize from model `Avatar`
    /// - Parameter avatar: as `Avatar`
    init (avatar: Avatar) {
        self.characterOption = avatar.characterOption ?? .default
        self.characterAction = avatar.characterAction ?? .default
        self.characterLocation = avatar.characterLocation ?? .default
    }
    
    /// Build description for  an`Avatar`
    var characterDescription: String {
        let prefix = isStartsWithVowel ? "An" : "A"
        let description =  "\(prefix) \(characterOption.rawValue) that is \(characterAction.rawValue) in the \(characterLocation.rawValue)"
        return description
    }
    
    // MARK: - Private
    /// Checks which letter (vowels or consonants) a option starts with
    private var isStartsWithVowel: Bool {
        let vowels = ["a", "e", "i", "o", "u"]
        let optionPrefixLength = 1
        let optionPrefix = characterOption.rawValue.prefix(optionPrefixLength).lowercased()
        return vowels.contains(optionPrefix)
    }
}
