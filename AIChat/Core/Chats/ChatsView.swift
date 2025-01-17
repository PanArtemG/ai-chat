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
//                    NavigationLink(destination: ChatMessagesView(chat: chat)) {
                    Text(chat.id)
//                    }
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
