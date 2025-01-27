//
//  CategoryListView.swift
//  AIChat
//
//  Created by Artem Panasenko on 26.01.2025.
//

import SwiftUI

struct CategoryListView: View {
    @Binding var path: [NavigationPathOption]
    @State var avatars: [Avatar] = Avatar.mocks
    
    var category: CharacterOption = .alien
    var imageUrlString: String = Constants.randomImageUrl
    
    var body: some View {
        List {
            CategoryCellView(
                title: category.pluralized.capitalized,
                imageUrlString: imageUrlString,
                font: .largeTitle,
                cornerRadius: 0
            )
            .removeListRowFormatting()
            
            ForEach(avatars, id: \.self) { avatar in
                CustomListCellView(
                    imageUrl: avatar.profileImageUrl,
                    title: avatar.name,
                    subtitle: avatar.characteDescription
                )
                .anyButton(.highlight) {
                    onAvatarPressed(avatar: avatar)
                }
                .removeListRowFormatting()
            }
        }
        .ignoresSafeArea()
        .listStyle(.plain)
    }
    
    // MARK: - Busyness logik
    private func onAvatarPressed(avatar: Avatar) {
        let pathOption: NavigationPathOption = .chat(avatarId: avatar.id)
        path.append(pathOption)
    }
}

// MARK: - Preview
#Preview {
    CategoryListView(path: .constant([]))
}
