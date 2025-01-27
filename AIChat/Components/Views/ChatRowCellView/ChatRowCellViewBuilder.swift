//
//  ChatRowCellViewBuilder.swift
//  AIChat
//
//  Created by Artem Panasenko on 17.01.2025.
//

import SwiftUI

struct ChatRowCellViewBuilder: View {
    var currentUserId: String? = ""
    var chat: Chat = .mock
    var getAvatar: () async -> Avatar?
    var getLastMessage: () async -> ChatMessage?
    
    @State private var avatar: Avatar?
    @State private var lastMessage: ChatMessage?
    
    @State private var didLoadAvatar: Bool = false
    @State private var didLoadLastMessage: Bool = false
    
    private var isLoading: Bool {
        !(didLoadAvatar && didLoadLastMessage)
    }
    
    private var hasNewMessageInChat: Bool {
        guard let lastMessage, let currentUserId else {
            return false
        }
        return lastMessage.hasBeenSeenBy(userId: currentUserId)
    }
    
    private var subheadline: String? {
        if isLoading {
            return "Loading..."
        }
        
        if avatar == nil && lastMessage == nil {
            return "Error loading data"
        } else {
            return lastMessage?.content
        }
    }
    
    var body: some View {
        ChatRowCellIView(
            imageUrl: avatar?.profileImageUrl,
            headline: isLoading ? "Loading..." : avatar?.name,
            subheadline: subheadline,
            hasNewMessageInChat: isLoading ? false : hasNewMessageInChat
        )
        .redacted(reason: isLoading ? .placeholder : [])
        .task {
            avatar = await getAvatar()
            didLoadAvatar = true
        }
        .task {
            lastMessage = await getLastMessage()
            didLoadLastMessage = true
        }
    }
}

// MARK: - Preview
#Preview {
    VStack {
        ChatRowCellViewBuilder(
            getAvatar: {
                try? await Task.sleep(for: .seconds(5))
                return .mock
            },
            getLastMessage: {
                try? await Task.sleep(for: .seconds(5))
                return .mock
            }
        )
        ChatRowCellViewBuilder(
            getAvatar: {
                return .mock
            },
            getLastMessage: {
                return .mock
            }
        )
        ChatRowCellViewBuilder(
            getAvatar: {
                return nil
            },
            getLastMessage: {
                return nil
            }
        )
    }
}
