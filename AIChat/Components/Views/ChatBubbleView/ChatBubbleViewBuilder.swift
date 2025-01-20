//
//  ChatBubbleViewBuilder.swift
//  AIChat
//
//  Created by Artem Panasenko on 20.01.2025.
//

import SwiftUI

struct ChatBubbleViewBuilder: View {
    var message: ChatMessage = .mock
    var isCurrentUser: Bool = false
    var avatarImageUrlString: String?
    
    private var textColor: Color {
        isCurrentUser ? .white : .primary
    }
    
    private var messageColor: Color {
        isCurrentUser ? .accent : .init(uiColor: .systemGray6)
    }
    
    private var messageAlignment: Alignment {
        isCurrentUser ? .trailing : .leading
    }
    
    private var messageEdgeSet: Edge.Set {
        isCurrentUser ? .leading : .trailing
    }
    
    var body: some View {
        ChatBubbleView(
            text: message.content ?? "",
            textColor: textColor,
            messageColor: messageColor,
            showAvatar: !isCurrentUser,
            imageUrlString: avatarImageUrlString
        )
        .frame(maxWidth: .infinity, alignment: messageAlignment)
        .padding(messageEdgeSet, 75)
    }
}

// MARK: - Preview
#Preview {
    ScrollView {
        VStack(spacing: 24) {
            ChatBubbleViewBuilder()
            ChatBubbleViewBuilder(isCurrentUser: true)
            ChatBubbleViewBuilder(
                message: ChatMessage(
                    id: UUID().uuidString,
                    chatId: UUID().uuidString,
                    content: "This is a long message, it should wrap around the bubble view, so you can see how it works, this is a long message, it should wrap around the bubble view, so you can see how it works"
                )
            )
            ChatBubbleViewBuilder(
                message: ChatMessage(
                    id: UUID().uuidString,
                    chatId: UUID().uuidString,
                    content: "This is a long message, it should wrap around the bubble view, so you can see how it works, this is a long message, it should wrap around the bubble view, so you can see how it works"
                ),
                isCurrentUser: true
            )
        }
        .padding(12)
    }
}
