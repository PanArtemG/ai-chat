//
//  CategoryCellView.swift
//  AIChat
//
//  Created by Artem Panasenko on 09.01.2025.
//

import SwiftUI

struct CategoryCellView: View {
    var title: String = "Aliens"
    var imageUrlString: String = Constants.randomImageUrl
    var font: Font = .title2
    var cornerRadius: CGFloat = 16
    
    var body: some View {
        ImageLoaderView(urlString: imageUrlString)
            .aspectRatio(1, contentMode: .fit)
            .overlay(alignment: .bottomLeading) {
                Text(title)
                    .font(font)
                    .fontWeight(.semibold)
                    .padding()
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .addingGradientBackgroundForText()
            }
            .cornerRadius(cornerRadius)
    }
}

// MARK: - Preview
#Preview {
    VStack {
        CategoryCellView()
            .frame(width: 150)
        CategoryCellView()
            .frame(width: 250)
        CategoryCellView()
            .frame(width: 350)
    }
}
