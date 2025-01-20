//
//  ChatView.swift
//  AIChat
//
//  Created by Artem Panasenko on 20.01.2025.
//

import SwiftUI

struct ChatView: View {
    @State private var messages: [ChatMessage] = ChatMessage.mocks
    @State private var avatar: Avatar? = .mock
    @State private var currentUser: User? = .mock
    
    private var messageSpacing: CGFloat = 24
    private var padding: CGFloat = 8
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                LazyVStack(spacing: messageSpacing) {
                    ForEach(messages) { message in
                        let isCurrentUser = message.authorId == currentUser?.id
                        let avatarImageUrlString = isCurrentUser ? nil : avatar?.profileImageUrl
                        ChatBubbleViewBuilder(
                            message: message,
                            isCurrentUser: isCurrentUser,
                            avatarImageUrlString: avatarImageUrlString
                        )
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(padding)
            }
        }
        .navigationTitle(avatar?.name ?? "Chat")
        .toolbarTitleDisplayMode(.inline)
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        ChatView()
    }
}
