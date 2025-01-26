//
//  ChatsView.swift
//  AIChat
//
//  Created by Artem Panasenko on 05.01.2025.
//

import SwiftUI

struct ChatsView: View {
    @State private var chats: [Chat] = Chat.mocks
    @State private var path: [NavigationPathOption] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
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
            .navigationTitle("Chats")
            .navigationDestinationForCoreModule(path: $path)
        }
    }
    
    // MARK: - Busyness logik
    private func onChatPressed(chat: Chat) {
        let pathOption: NavigationPathOption = .chat(avatarId: chat.avatarId)
        path.append(pathOption)
    }
}

// MARK: - Preview
#Preview {
    ChatsView()
}
