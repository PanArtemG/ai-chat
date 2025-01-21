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
    @State private var inputText: String = ""
    @State private var scrollPosition: String?
    @State private var showChatSettings: AnyAppAlert?
    @State private var alert: AnyAppAlert?
    
    private let messageSpacing: CGFloat = 24
    private let cornerRadius: CGFloat = 100
    private let paddingConversationSection: CGFloat = 8
    private let paddingTextField: CGFloat = 12
    private let retreatFromButton: CGFloat = 40
    private let sizeButton: CGFloat = 32
    private let paddingHTextFieldSection: CGFloat = 12
    private let paddingVTextFieldSection: CGFloat = 6
    
    var body: some View {
        VStack(spacing: 0) {
            conversationSection
            textFieldSection
        }
        .navigationTitle(avatar?.name ?? "Chat")
        .toolbarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                
            }
            ToolbarItem(placement: .topBarTrailing) {
                Image(systemName: "ellipsis")
                    .foregroundStyle(.accent)
                    .padding(8)
                    .anyButton {
                        onChatSettingsPressed()
                    }
            }
        }
        .showCustomAlert(type: .confirmationDialog, alert: $showChatSettings)
        .showCustomAlert(alert: $alert)
    }
    
    // MARK: - View's components
    private var conversationSection: some View {
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
                    .id(message.id)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(paddingConversationSection)
            .rotationEffect(.degrees(180))
        }
        .rotationEffect(.degrees(180))
        .scrollPosition(id: $scrollPosition, anchor: .bottom)
        .animation(.default, value: scrollPosition)
    }
    
    private var textFieldSection: some View {
        TextField("Type your message...", text: $inputText)
            .keyboardType(.alphabet)
            .autocorrectionDisabled()
            .padding(paddingTextField)
            .padding(.trailing, retreatFromButton)
            .overlay(
                Image(systemName: "arrow.up.circle.fill")
                    .font(.system(size: sizeButton))
                    .padding(.trailing, 4)
                    .foregroundStyle(.accent)
                    .anyButton(.plain) {
                        onSendMessagePressed()
                    }
                , alignment: .trailing
            )
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(Color.systemBackground)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                }
            )
            .padding(.horizontal, paddingHTextFieldSection)
            .padding(.vertical, paddingVTextFieldSection)
            .background(Color(uiColor: .secondarySystemBackground))
    }
    
    // MARK: - Actions
    private func onSendMessagePressed() {
        guard let currentUser else {
            return
        }
        let content = inputText
        
        do {
            try TextValidationHelper.checkIfTextIsValid(text: content)
            let message = ChatMessage(
                id: UUID().uuidString,
                chatId: UUID().uuidString,
                authorId: currentUser.id,
                content: content,
                seenById: nil,
                createdAt: Date.now,
                updatedAt: nil
            )
            messages.append(message)
            scrollPosition = message.id
            inputText = ""
        } catch {
            alert = AnyAppAlert(title: error.localizedDescription)
        }
    }
    
    private func onChatSettingsPressed() {
        showChatSettings = AnyAppAlert(
            title: "",
            subtitle: "What would you like to do?",
            buttons: {
                AnyView(
                    Group {
                        Button("Report User / Chat", role: .destructive) {
                            
                        }
                        Button("Delete Chat", role: .destructive) {
                            
                        }
                    }
                )
            }
        )
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        ChatView()
    }
}
