//
//  CategoryListView.swift
//  AIChat
//
//  Created by Artem Panasenko on 26.01.2025.
//

import SwiftUI

struct CategoryListView: View {
    @Environment(AvatarManager.self) private var avatarManager
    @State var avatars: [Avatar] = []
    @State private var showAlert: AnyAppAlert?
    @State private var isLoading: Bool = true
    
    @Binding var path: [NavigationPathOption]
    
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
            
            if avatars.isEmpty && isLoading{
                ProgressView()
                    .padding(40)
                    .frame(maxWidth: .infinity)
                    .listRowSeparator(.hidden)
                    .removeListRowFormatting()
            } else {
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
        }
        .ignoresSafeArea()
        .listStyle(.plain)
        .showCustomAlert(alert: $showAlert)
        .task {
            await loadAvatars()
        }
    }
    
    // MARK: - Busyness logik
    private func onAvatarPressed(avatar: Avatar) {
        let pathOption: NavigationPathOption = .chat(avatarId: avatar.id)
        path.append(pathOption)
    }
    
    private func loadAvatars() async {
        do {
            avatars = try await avatarManager.getAvatarsForCategory(category: category)
        } catch {
            // FIXME: Remove after fix DB connection
            avatars = Avatar.mocks.filter { $0.characterOption == category }
            showAlert = AnyAppAlert(error: error)
        }
        isLoading = false
    }
}

// MARK: - Preview
#Preview {
    CategoryListView(path: .constant([]))
        .environment(AvatarManager(remote: MockAvatarService(), local: MockLocalAvatarPersistence()))
}
