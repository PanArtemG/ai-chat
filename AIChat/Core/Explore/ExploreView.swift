//
//  ExploreView.swift
//  AIChat
//
//  Created by Artem Panasenko on 05.01.2025.
//

import SwiftUI

struct ExploreView: View {
    @State private var featuredAvatars: [Avatar] = Avatar.mocks
    @State private var categories: [CharacterOption] = CharacterOption.allCases
    @State private var popularAvatars: [Avatar] = Avatar.mocks
    @State private var path: [NavigationPathOption] = []
    
    private let categorySectionHeight: CGFloat = 140
    private let spacing: CGFloat = 12
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                featuredSection
                categorySection
                popularSection
            }
            .navigationTitle("Explore")
            .navigationDestinationForCoreModule(path: $path)
        }
    }
    
    // MARK: - View's components
    private var featuredSection: some View {
        Section {
            ZStack {
                CarouselView(items: featuredAvatars) { avatar in
                    HeroCellView(
                        title: avatar.name,
                        subtitle: avatar.characteDescription,
                        imageUrl: avatar.profileImageUrl
                    )
                    .anyButton(.highlight) {
                        onAvatarPressed(avatar: avatar)
                    }
                }
            }
            .removeListRowFormatting()
        } header: {
            Text("Featured")
        }
    }
    
    private var categorySection: some View {
        Section {
            ZStack {
                ScrollView(.horizontal) {
                    HStack(spacing: spacing) {
                        ForEach(categories, id: \.self) { category in
                            let avatar = popularAvatars.first(where: { $0.characterOption == category })
                            if let categoryImageUrl = avatar?.profileImageUrl {
                                CategoryCellView(
                                    title: category.pluralized.capitalized,
                                    imageUrlString: categoryImageUrl
                                )
                                .anyButton(.plain) {
                                    onCategoryPressed(
                                        category: category,
                                        imageUrlString: categoryImageUrl
                                    )
                                }
                            }
                        }
                    }
                }
                .frame(height: categorySectionHeight)
                .scrollIndicators(.hidden)
                .scrollTargetLayout()
                .scrollTargetBehavior(.viewAligned)
            }
            .removeListRowFormatting()
        } header: {
            Text("Categories")
        }
    }
    
    private var popularSection: some View {
        Section {
            ForEach(popularAvatars, id: \.self) { avatar in
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
        } header: {
            Text("Popular")
        }
    }
    
    // MARK: - Busyness logik
    private func onAvatarPressed(avatar: Avatar) {
        let pathOption: NavigationPathOption = .chat(avatarId: avatar.id)
        path.append(pathOption)
    }
    
    private func onCategoryPressed(category: CharacterOption, imageUrlString: String) {
        let pathOption: NavigationPathOption = .category(
            category: category,
            imageUrlString: imageUrlString
        )
        path.append(pathOption)
    }
}

// MARK: - Preview
#Preview {
    ExploreView()
}
