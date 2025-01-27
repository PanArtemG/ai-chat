//
//  ImageLoaderView.swift
//  AIChat
//
//  Created by Artem Panasenko on 06.01.2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageLoaderView: View {
    var urlString = Constants.randomImageUrl
    var resizingMode: ContentMode = .fill
    var forceTransitionAnimation: Bool = false
    
    var body: some View {
        Rectangle()
            .opacity(0.001)
            .overlay(
                WebImage(url: URL(string: urlString))
                    .resizable()
                    .indicator(.activity)
                    .aspectRatio(contentMode: resizingMode)
                    .allowsHitTesting(false)
            )
            .clipped()
            .ifSatisfiedCondition(forceTransitionAnimation) { content in
                content
                    .drawingGroup()
            }
        
    }
}
// MARK: - Preview
#Preview {
    ImageLoaderView()
        .frame(width: 200, height: 300)
        .anyButton(.highlight) { }
}
