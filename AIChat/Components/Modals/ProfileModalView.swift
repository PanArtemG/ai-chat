//
//  ProfileModalView.swift
//  AIChat
//
//  Created by Artem Panasenko on 22.01.2025.
//

import SwiftUI

struct ProfileModalView: View {
    var imageUrlString: String?
    var title: String?
    var subtitle: String?
    var headline: String?
    var onXMarkPressed: () -> Void
    
    private let spacing: CGFloat = 4
    private let paddingDescriptionSection: CGFloat = 24
    private let radius: CGFloat = 16
    
    var body: some View {
        VStack(spacing: 0) {
            if let imageUrlString {
                ImageLoaderView(
                    urlString: imageUrlString,
                    forceTransitionAnimation: true
                )
                .aspectRatio(1, contentMode: .fit)
            }
            
            VStack(alignment: .leading, spacing: spacing) {
                if let title {
                    Text(title)
                        .font(.title)
                        .fontWeight(.semibold)
                }
                
                if let subtitle {
                    Text(subtitle)
                        .font(.title3)
                        .foregroundColor(.secondary)
                }
                if let headline {
                    Text(headline)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            .padding(paddingDescriptionSection)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(.thinMaterial)
        .cornerRadius(radius)
        .overlay(
            Image(systemName: "xmark.circle.fill")
                .font(.title)
                .foregroundStyle(.black)
                .padding(4)
                .tappableBackground()
                .anyButton {
                    onXMarkPressed()
                }
                .padding(8)
            
            , alignment: .topTrailing
        )
    }
}

// MARK: - Preview
#Preview("Modal w/ image") {
    ZStack {
        Color.gray.ignoresSafeArea()
        
        ProfileModalView(
            imageUrlString: Constants.randomImageUrl,
            title: "Alpha",
            subtitle: "ALien",
            headline: "An alien in the park.",
            onXMarkPressed: { }
        )
        .padding(40)
    }
}

#Preview("Modal w/out image") {
    ZStack {
        Color.gray.ignoresSafeArea()
        
        ProfileModalView(
            imageUrlString: nil,
            title: "Alpha",
            headline: "An alien in the park.",
            onXMarkPressed: { }
        )
        .padding(40)
    }
}
