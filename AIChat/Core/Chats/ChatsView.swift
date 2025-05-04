//
//  ChatsView.swift
//  AIChat
//
//  Created by Artem Panasenko on 05.01.2025.
//

import SwiftUI

struct ChatsView: View {
    @Environment(AvatarManager.self) private var avatarManager
    @State private var chats: [Chat] = Chat.mocks
    @State private var recentAvatars: [Avatar] = Avatar.mocks
    
    @State private var path: [NavigationPathOption] = []
    
    private let recentsSectionHeight: CGFloat = 120
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                if !recentAvatars.isEmpty {
                    recentsSection
                }
                
                chatsSection
            }
            .navigationTitle("Chats")
            .navigationDestinationForCoreModule(path: $path)
            .onAppear {
                loadRecentAvatars()
            }
        }
    }
    
    private func loadRecentAvatars() {
        do {
            recentAvatars = try avatarManager.getRecentAvatars()
        } catch {
            print("Failed to load recent avatars: \(error)")
        }
    }
    
    private var chatsSection: some View {
        Section {
            if chats.isEmpty {
                Text("No chats yet")
                    .foregroundStyle(.secondary)
                    .font(.title3)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .padding(.top, 40)
                    .removeListRowFormatting()
            } else {
                ForEach(chats) { chat in
                    ChatRowCellViewBuilder(
                        currentUserId: nil, // FIXME: Add cuid
                        chat: chat,
                        getAvatar: {
                            try? await Task.sleep(for: .seconds(1))
                            return Avatar.mocks.randomElement() ?? .mock
                        },
                        getLastMessage: {
                            try? await Task.sleep(for: .seconds(1))
                            return ChatMessage.mocks.randomElement() ?? .mock
                        }
                    )
                    .anyButton(.highlight) {
                        onChatPressed(chat: chat)
                    }
                    .removeListRowFormatting()
                }
            }
        } header: {
            Text(!chats.isEmpty ? "chats" : "")
        }
    }
    
    private var recentsSection: some View {
        Section {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 8) {
                    ForEach(recentAvatars, id: \.self) { avatar in
                        if let profileImageUrl = avatar.profileImageUrl {
                            VStack(spacing: 8) {
                                ImageLoaderView(urlString: profileImageUrl)
                                    .aspectRatio(1, contentMode: .fit)
                                    .clipShape(Circle())
                                
                                Text(avatar.name ?? "")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            .anyButton {
                                onAvatarPressed(avatar: avatar)
                            }
                        }
                    }
                }
                .padding(.top, 12)
            }
            .frame(height: recentsSectionHeight)
            .scrollIndicators(.hidden)
            .removeListRowFormatting()
        } header: {
            Text("recents")
        }

    }
    
    // MARK: - Busyness logik
    private func onChatPressed(chat: Chat) {
        let pathOption: NavigationPathOption = .chat(avatarId: chat.avatarId)
        path.append(pathOption)
    }
    
    private func onAvatarPressed(avatar: Avatar) {
        let pathOption: NavigationPathOption = .chat(avatarId: avatar.id)
        path.append(pathOption)
    }
}

// MARK: - Preview
#Preview {
    ChatsView()
        .environment(AvatarManager(remote: MockAvatarService(), local: MockLocalAvatarPersistence()))
}
