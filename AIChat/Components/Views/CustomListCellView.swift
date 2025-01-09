//
//  CustomListCellView.swift
//  AIChat
//
//  Created by Artem Panasenko on 09.01.2025.
//

import SwiftUI

struct CustomListCellView: View {
    
    var imageUrl: String? = Constants.randomImageUrl
    var title: String? = "Alpha"
    var subtitle: String? = "This is some subtitle for Cell View"
    
    private let aspectRatio: CGFloat = 1
    private let imageSpacing: CGFloat = 8
    private let descriptionSpacing: CGFloat = 4
    private let imageHeight: CGFloat = 60
    private let cornerRadius: CGFloat = 16
    private let cellHorizontalPadding: CGFloat = 16
    private let cellVerticalPadding: CGFloat = 12
    
    var body: some View {
        HStack(spacing: imageSpacing) {
            ZStack {
                if let imageUrl {
                    ImageLoaderView(urlString: imageUrl)
                } else {
                    Rectangle()
                        .fill(.secondary.opacity(0.5))
                }
            }
            .aspectRatio(aspectRatio, contentMode: .fit)
            .frame(height: imageHeight)
            .cornerRadius(cornerRadius)
            
            VStack(alignment: .leading, spacing: descriptionSpacing) {
                if let title {
                    Text(title)
                        .font(.headline)
                }
                
                if let subtitle {
                    Text(subtitle)
                        .font(.subheadline)
                }
            }
            .lineLimit(1)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical, cellHorizontalPadding)
        .padding(.horizontal, cellVerticalPadding)
        .background(Color(uiColor: .systemBackground))
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        Color.gray.ignoresSafeArea()
        VStack {
            CustomListCellView()
            CustomListCellView(imageUrl: nil)
        }
    }
}
