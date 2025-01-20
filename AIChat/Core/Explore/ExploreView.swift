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
    
    private let categorySectionHeight: CGFloat = 140
    private let spacing: CGFloat = 12
    
    var body: some View {
        NavigationStack {
            List {
                featuredSection
                categorySection
                popularSection
            }
            .navigationTitle("Explore")
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
                        // action
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
                            CategoryCellView(
                                title: category.rawValue.capitalized,
                                imageUrlString: Constants.randomImageUrl
                            )
                            .anyButton(.plain) {
                                // action
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
                    // action
                }
                .removeListRowFormatting()
            }
        } header: {
            Text("Popular")
        }
    }
}

// MARK: - Preview
#Preview {
    ExploreView()
}
