//
//  ChatBubbleView.swift
//  AIChat
//
//  Created by Artem Panasenko on 20.01.2025.
//

import SwiftUI

struct ChatBubbleView: View {
    var text: String = "Sample Text!!!"
    var textColor: Color = .primary
    var messageColor: Color = .init(uiColor: .systemGray6)
    var showAvatar: Bool = true
    var imageUrlString: String?
    
    private let spacing: CGFloat = 8
    private let imageSize: CGFloat = 45
    private let imageOffset: CGFloat = 14
    private let paddingH: CGFloat = 16
    private let paddingV: CGFloat = 10
    private let radius: CGFloat = 6
    
    var body: some View {
        HStack(alignment: .top, spacing: spacing) {
            if showAvatar {
                ZStack {
                    if let imageUrlString {
                        ImageLoaderView(urlString: imageUrlString)
                        
                    } else {
                        Rectangle()
                            .fill(.secondary)
                    }
                }
                .frame(width: imageSize, height: imageSize)
                .clipShape(Circle())
                .offset(y: imageOffset)
            }
            
            Text(text)
                .font(.body)
                .foregroundStyle(textColor)
                .padding(.horizontal, paddingH)
                .padding(.vertical, paddingV)
                .background(messageColor)
                .cornerRadius(radius)
        }
        .padding(.bottom, showAvatar ? imageOffset : 0)
    }
}

// MARK: - Preview
#Preview {
    ScrollView {
        VStack(spacing: 16) {
            ChatBubbleView()
            ChatBubbleView(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
            ChatBubbleView()
            ChatBubbleView(
                textColor: .white,
                messageColor: .accent,
                showAvatar: false
            )
            ChatBubbleView(
                text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                showAvatar: false
            )
            ChatBubbleView(
                text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                textColor: .white,
                messageColor: .accent,
                showAvatar: false
            )
        }
    }
    .padding(8)
    
}
