//
//  AsyncCallToActionButton.swift
//  AIChat
//
//  Created by Artem Panasenko on 20.01.2025.
//

import SwiftUI

struct AsyncCallToActionButton: View {
    var title: String
    var isLoading: Bool
    var action: () -> Void
    
    var body: some View {
        ZStack {
            if isLoading {
                ProgressView()
                    .tint(.white)
            } else {
                Text(title)
            }
        }
        .callToActionButton()
        .anyButton(.press) {
            action()
        }
        .disabled(isLoading)
    }
}

private struct PreviewView: View {
    @State private var isLoading: Bool = false
    
    var body: some View {
        AsyncCallToActionButton(
            title: "Finish",
            isLoading: isLoading,
            action: {
                isLoading = true
                
                Task {
                    try? await Task.sleep(for: .seconds(2))
                    isLoading = false
                }
            }
        )
    }
}

#Preview {
    PreviewView()
        .padding()
}
