//
//  ModalSupportView.swift
//  AIChat
//
//  Created by Artem Panasenko on 22.01.2025.
//

import SwiftUI

struct ModalSupportView<Content: View>: View {
    @Binding var showModal: Bool
    @ViewBuilder var content: Content
    
    var body: some View {
        ZStack {
            if showModal {
                Color.black.opacity(0.6)
                    .ignoresSafeArea()
                    .transition(AnyTransition.opacity.animation(.smooth))
                    .onTapGesture {
                        showModal = false
                    }
                    .zIndex(1)
                
                content
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                    .zIndex(2)
            }
        }
        .zIndex(9999)
        .animation(.bouncy, value: showModal)
    }
}

// MARK: - Preview
private struct PreviewView: View {
    @State var showModal: Bool = false
    
    var body: some View {
        Button("Click me") {
            showModal = true
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .showModal($showModal) {
            RoundedRectangle(cornerRadius: 30)
                .padding(40)
                .padding(.vertical, 80)
                .onTapGesture {
                    showModal = false
                }
                .transition(.move(edge: .top))
        }
    }
}

#Preview {
    PreviewView()
}
