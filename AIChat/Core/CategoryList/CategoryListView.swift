//
//  CategoryListView.swift
//  AIChat
//
//  Created by Artem Panasenko on 26.01.2025.
//

import SwiftUI

struct CategoryListView: View {
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
                .removeListRowFormatting()
            }
        }
        .ignoresSafeArea()
        .listStyle(.plain)
    }
}

// MARK: - Preview
#Preview {
    CategoryListView()
}
