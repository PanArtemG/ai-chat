//
//  HeroCellView.swift
//  AIChat
//
//  Created by Artem Panasenko on 07.01.2025.
//

import SwiftUI

struct HeroCellView: View {
    var title: String? = "This is some title"
    var subtitle: String? = "This is some subtitle for Hero Cell View"
    var imageUrl: String? = Constants.randomImageUrl
    
    private let spacing: CGFloat = 4
    private let radius: CGFloat = 16
    
    var body: some View {
        ZStack {
            if let urlString = imageUrl {
                ImageLoaderView(urlString: urlString)
            } else {
                Rectangle()
                    .fill(.accent)
            }
        }
        .overlay(alignment: .bottomLeading, content: {
            VStack(alignment: .leading, spacing: spacing) {
                if let title {
                    Text(title)
                        .font(.headline)
                }
                if let subtitle {
                    Text(subtitle)
                        .font(.subheadline)
                }
            }
            .foregroundStyle(.white)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .addingGradientBackgroundForText()
        })
        .background(.accent)
        .cornerRadius(radius)
    }
}

// MARK: - Preview
#Preview {
    ScrollView {
        VStack {
            HeroCellView()
                .frame(width: 300, height: 200)
            
            HeroCellView(imageUrl: nil)
                .frame(width: 200, height: 300)
            
            HeroCellView(title: nil)
                .frame(width: 300, height: 200)
            
            HeroCellView(subtitle: nil)
                .frame(width: 300, height: 200)
        }
        .frame(maxWidth: .infinity)
    }
}
