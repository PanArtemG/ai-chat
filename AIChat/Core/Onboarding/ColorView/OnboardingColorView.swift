//
//  OnboardingColorView.swift
//  AIChat
//
//  Created by Artem Panasenko on 06.01.2025.
//

import SwiftUI

struct OnboardingColorView: View {
    @State var selectedColor: Color?
    
    private var rowSpace: CGFloat = 16
    private var columns: [GridItem] {
        let count: Int = 3
        let spacing: CGFloat = 16
        let gridItem = GridItem(.flexible(), spacing: spacing)
        return Array(repeating: gridItem, count: count)
    }
    private var profileColors: [Color] = [
        .red,
        .blue,
        .green,
        .yellow,
        .purple,
        .orange,
        .cyan,
        .teal,
        .indigo
    ]
    private var padding: CGFloat = 24
    
    var body: some View {
        ScrollView {
            colorsGrid
                .padding(.horizontal, padding)
        }
        .safeAreaInset(edge: .bottom, alignment: .center, spacing: 16, content: {
            ZStack {
                if let selectedColor {
                    ctaButton(selectedColor: selectedColor)
                        .transition(AnyTransition.move(edge: .bottom))
                }
            }
            .padding(padding)
            .background(Color(uiColor: .systemBackground))
        })
        .animation(.bouncy, value: selectedColor)
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private var colorsGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .center,
            spacing: rowSpace,
            pinnedViews: [.sectionHeaders],
            content: {
                Section {
                    ForEach(profileColors, id: \.self) { color in
                        Circle()
                            .fill(.accent.opacity(0.5))
                            .overlay(
                                color
                                    .clipShape(Circle())
                                    .padding(selectedColor == color ? 10 : 0)
                            )
                            .onTapGesture {
                                selectedColor = color
                            }
                    }
                } header: {
                    Text("Select a profile color")
                }
            }
        )
    }
    
    private func ctaButton(selectedColor: Color) -> some View {
        NavigationLink {
            OnboardingCompletedView(selectedColor: selectedColor)
        } label: {
            Text("Continue")
                .callToActionButton()
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        OnboardingColorView()
    }
    .environment(AppState())
}
