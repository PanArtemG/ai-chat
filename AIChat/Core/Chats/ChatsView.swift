//
//  ChatsView.swift
//  AIChat
//
//  Created by Artem Panasenko on 05.01.2025.
//

import SwiftUI

struct ChatsView: View {
    
    @State private var chats: [Chat] = Chat.mocks
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(chats) { chat in
                    NavigationLink {
                        ChatView()
                    } label: {
                        ChatRowCellViewBuilder(
                            currentUserId: nil, // FIXME: Add cuid
                            chat: chat,
                            getAvatar: {
                                try? await Task.sleep(for: .seconds(2))
                                return .mock
                            },
                            getLastMessage: {
                                try? await Task.sleep(for: .seconds(2))
                                return .mock
                            }
                        )
                        .anyButton(.highlight) {
                            
                        }
                        .removeListRowFormatting()
                    }
                }
            }
            .navigationTitle("Chats")
        }
    }
}

// MARK: - Preview
#Preview {
    ChatsView()
}
