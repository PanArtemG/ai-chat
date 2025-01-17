//
//  ChatRowCellIView.swift
//  AIChat
//
//  Created by Artem Panasenko on 17.01.2025.
//

import SwiftUI

struct ChatRowCellIView: View {
    var imageUrl: String? = Constants.randomImageUrl
    var headline: String? = "Alpha"
    var subheadline: String? = "This is a last message in the chat."
    var hasNewMessageInChat: Bool = true
    
    private let spacingHS: CGFloat = 8
    private let spacingVS: CGFloat = 4
    private let paddingCellV: CGFloat = 12
    private let paddingCellH: CGFloat = 8
    private let cornerRadius: CGFloat = 6
    private let avatarSize: CGFloat = 50
    
    var body: some View {
        HStack(spacing: spacingHS) {
            
            ZStack {
                if let imageUrl {
                    ImageLoaderView(urlString: imageUrl)
                } else {
                    Rectangle()
                        .fill(.secondary.opacity(0.5))
                }
            }
            .frame(width: avatarSize, height: avatarSize)
            .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: spacingVS) {
                Text(headline ?? "")
                    .font(.headline)
                Text(subheadline ?? "")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            if hasNewMessageInChat {
                Text("NEW")
                    .font(.caption)
                    .bold()
                    .padding(6)
                    .foregroundStyle(.white)
                    .background(.blue)
                    .cornerRadius(cornerRadius)
            }
        }
        .padding(.vertical, paddingCellV)
        .padding(.horizontal, paddingCellH)
        .background(Color(uiColor: .systemBackground))
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        Color.gray.ignoresSafeArea()
        List {
            ChatRowCellIView()
                .removeListRowFormatting()
            ChatRowCellIView(headline: nil, hasNewMessageInChat: false)
                .removeListRowFormatting()
            ChatRowCellIView(imageUrl: nil)
                .removeListRowFormatting()
            ChatRowCellIView(subheadline: nil)
                .removeListRowFormatting()
            ChatRowCellIView(headline: nil)
                .removeListRowFormatting()
            ChatRowCellIView()
                .removeListRowFormatting()
        }
    }
}
