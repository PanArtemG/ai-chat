//
//  ChatView.swift
//  AIChat
//
//  Created by Artem Panasenko on 20.01.2025.
//

import SwiftUI

struct ChatView: View {
    @Environment(AvatarManager.self) private var avatarManager
    @State private var messages: [ChatMessage] = ChatMessage.mocks
    @State private var avatar: Avatar?
    @State private var currentUser: UserModel? = .mock
    @State private var inputText: String = ""
    @State private var scrollPosition: String?
    
    @State private var showAlert: AnyAppAlert?
    @State private var showChatSettings: AnyAppAlert?
    @State private var showProfileModal: Bool = false
    
    var avatarId: String = Avatar.mocks.shuffled().first!.id

    private let messageSpacing: CGFloat = 24
    private let cornerRadius: CGFloat = 100
    private let paddingConversationSection: CGFloat = 8
    private let paddingTextField: CGFloat = 12
    private let retreatFromButton: CGFloat = 40
    private let sizeButton: CGFloat = 32
    private let paddingHTextFieldSection: CGFloat = 12
    private let paddingVTextFieldSection: CGFloat = 6
    private let paddingProfileModal: CGFloat = 40
    
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
        .showCustomAlert(alert: $showAlert)
        .showModal($showProfileModal) {
            if let avatar {
                profileModal(avatar: avatar)
            }
        }
    }
    
    // MARK: - View's components
    private func profileModal(avatar: Avatar) -> some View {
        ProfileModalView(
            imageUrlString: avatar.profileImageUrl,
            title: avatar.name,
            subtitle: avatar.characterOption?.rawValue.capitalized,
            headline: avatar.characteDescription,
            onXMarkPressed: {
                showProfileModal = false
            }
        )
        .padding(paddingProfileModal)
        .transition(.slide)
    }
    
    private var conversationSection: some View {
        ScrollView {
            LazyVStack(spacing: messageSpacing) {
                ForEach(messages) { message in
                    let isCurrentUser = message.authorId == currentUser?.id
                    let avatarImageUrlString = isCurrentUser ? nil : avatar?.profileImageUrl
                    ChatBubbleViewBuilder(
                        message: message,
                        isCurrentUser: isCurrentUser,
                        avatarImageUrlString: avatarImageUrlString,
                        onAvatarImagePressed: onAvatarImagePressed
                        
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
        .task {
            await loadAvatar()
        }
    }
    
    private func loadAvatar() async {
        do {
            let avatar = try await avatarManager.getAvatar(id: avatarId)
            self.avatar = avatar
            try? avatarManager.addRecentAvatar(avatar)
        } catch {
            // FIXME: Remove after fix DB connection
            if let avatar = try? await MockAvatarService().getAvatar(id: avatarId) {
                self.avatar = avatar
                try? avatarManager.addRecentAvatar(avatar)
            }
            print("Error loading avatar: \(error)")
        }
        
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
    
    // MARK: - Busyness logik
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
            showAlert = AnyAppAlert(title: error.localizedDescription)
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
    
    private func onAvatarImagePressed() {
        showProfileModal = true
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        ChatView()
            .environment(AvatarManager(remote: MockAvatarService(), local: MockLocalAvatarPersistence()))
    }
}
