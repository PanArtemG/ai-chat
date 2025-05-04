//
//  ExploreView.swift
//  AIChat
//
//  Created by Artem Panasenko on 05.01.2025.
//

import SwiftUI

struct ExploreView: View {
    @Environment(AvatarManager.self) private var avatarManager
    @State private var featuredAvatars: [Avatar] = []
    @State private var categories: [CharacterOption] = CharacterOption.allCases
    @State private var popularAvatars: [Avatar] = []
    @State private var path: [NavigationPathOption] = []
    
    private let categorySectionHeight: CGFloat = 140
    private let spacing: CGFloat = 12
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                if featuredAvatars.isEmpty && popularAvatars.isEmpty {
                    ProgressView()
                        .padding(40)
                        .frame(maxWidth: .infinity)
                        .removeListRowFormatting()
                }
                if !featuredAvatars.isEmpty {
                    featuredSection
                }
                
                if !popularAvatars.isEmpty {
                    categorySection
                    popularSection
                }
            }
            .navigationTitle("Explore")
            .navigationDestinationForCoreModule(path: $path)
            .task {
                await loadFeaturedAvatars()
            }
            .task {
                await loadPopularAvatars()
            }
        }
    }
    
    private func loadFeaturedAvatars() async {
        guard featuredAvatars.isEmpty else {
            return
        }
        do {
            featuredAvatars = try await avatarManager.getFeaturedAvatars()
        } catch {
            // FIXME: Remove after fix DB connection
            featuredAvatars = Avatar.mocks.shuffled().first(upTo: 5) ?? []
            print("Error loading featured avatars: \(error)")
        }
    }
    
    private func loadPopularAvatars() async {
        guard popularAvatars.isEmpty else {
            return
        }
        do {
            popularAvatars = try await avatarManager.getPopularAvatars()
        } catch {
            // FIXME: Remove after fix DB connection
            popularAvatars = Avatar.mocks.shuffled()
            print("Error loading popular avatars: \(error)")
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
        .environment(AvatarManager(service: MockAvatarService()))
}
