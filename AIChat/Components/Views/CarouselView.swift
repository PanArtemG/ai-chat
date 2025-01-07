//
//  CarouselView.swift
//  AIChat
//
//  Created by Artem Panasenko on 07.01.2025.
//

import SwiftUI

struct CarouselView<Content: View, T: Hashable>: View {
    var items: [T]
    
    @State private var selection: T?
    @ViewBuilder var content: (T) -> Content
    
    private let spacingVS: CGFloat = 12
    private let spacingHS: CGFloat = 8
    private let scrollViewHeight: CGFloat = 200
    private let circleSize: CGFloat = 8
    
    var body: some View {
        VStack(spacing: spacingVS) {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    ForEach(items, id: \.self) { item in
                        content(item)
                            .scrollTransition(.interactive.threshold(.visible(0.95)), transition: { content, phase in
                                content.scaleEffect(phase.isIdentity ? 1 : 0.8)
                            })
                            .containerRelativeFrame(.horizontal, alignment: .center)
                            .id(item)
                    }
                }
            }
            .frame(height: scrollViewHeight)
            .scrollIndicators(.hidden)
            .scrollTargetLayout()
            .scrollTargetBehavior(.paging)
            .scrollPosition(id: $selection)
            .onChange(of: items.count) { _, _ in
                updateSelectionIfNeeded()
            }
            .onAppear {
                updateSelectionIfNeeded()
            }
            
            HStack(spacing: spacingHS) {
                ForEach(items, id: \.self) { item in
                    Circle()
                        .fill(item == selection ? .accent : .secondary)
                        .frame(width: circleSize)
                }
            }
            .animation(.linear, value: selection)
        }
    }
    
    private func updateSelectionIfNeeded() {
        if selection == nil || selection == items.last {
            selection = items.first
        }
    }
}

// MARK: - Preview
#Preview {
    CarouselView(items: AvatarModel.mocks) { item in
        HeroCellView(
            title: item.name,
            subtitle: item.characteDescription,
            imageUrl: item.profileImageUrl
        )
    }
    .padding()
}
