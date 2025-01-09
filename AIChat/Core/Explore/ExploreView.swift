//
//  ExploreView.swift
//  AIChat
//
//  Created by Artem Panasenko on 05.01.2025.
//

import SwiftUI

struct ExploreView: View {
    @State private var featuredAvatars: [AvatarModel] = AvatarModel.mocks
    @State private var categories: [CharacterOption] = CharacterOption.allCases
    
    private let categorySectionHeight: CGFloat = 140
    private let spacing: CGFloat = 12
    
    var body: some View {
        NavigationStack {
            List {
                featuredSection
                categorySection
            }
        }
    }
    
    // MARK: - View components
    private var featuredSection: some View {
        Section {
            ZStack {
                CarouselView(items: featuredAvatars) { avatar in
                    HeroCellView(
                        title: avatar.name,
                        subtitle: avatar.characteDescription,
                        imageUrl: avatar.profileImageUrl
                    )
                }
            }
            .removeListFormatting()
        } header: {
            Text("Featured Avatars")
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
                        }
                        
                    }
                }
                .frame(height: categorySectionHeight)
                .scrollIndicators(.hidden)
                .scrollTargetLayout()
                .scrollTargetBehavior(.viewAligned)
            }
            .removeListFormatting()
        } header: {
            Text("Categories")
        }
    }
}

// MARK: - Preview
#Preview {
    ExploreView()
}
