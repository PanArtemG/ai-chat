//
//  ButtonViewModifiers.swift
//  AIChat
//
//  Created by Artem Panasenko on 09.01.2025.
//

import SwiftUI

// MARK: - Types
/// Button style option type
enum ButtonStyleOption {
    case press
    case highlight
    case plain
}

// MARK: - Implementation
/// HighlightButtonStyle as `ButtonStyle`
struct HighlightButtonStyle: ButtonStyle {
    private var colorWhenPressed: Color = Color.accent.opacity(0.4)
    private var defaultColor: Color = Color.accent.opacity(0)
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .overlay {
                configuration.isPressed ? colorWhenPressed : defaultColor
            }
            .animation(.smooth, value: configuration.isPressed)
    }
}

/// PressableButtonStyle as `ButtonStyle`
struct PressableButtonStyle: ButtonStyle {
    private var colorWhenPressed: Color = Color.accent.opacity(0.4)
    private var defaultColor: Color = Color.accent.opacity(0)
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.smooth, value: configuration.isPressed)
    }
}

// MARK: - Extension
extension View {
    @ViewBuilder
    func anyButton(
        _ option: ButtonStyleOption = .plain,
        action: @escaping () -> Void
    ) -> some View {
        switch option {
        case .press:
            self.pressableButton(action: action)
        case .highlight:
            self.highlightButton(action: action)
        case .plain:
            self.plainButton(action: action)
        }
    }
    
    /// Custom  style as`HighlightButtonStyle`
    private func highlightButton(action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            self
        }
        .buttonStyle(HighlightButtonStyle())
    }
    
    /// Custom  style as`PressableButtonStyle`
    private func pressableButton(action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            self
        }
        .buttonStyle(PressableButtonStyle())
    }
    
    /// Default  style as`PlainButtonStyle`
    private func plainButton(action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            self
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Preview
#Preview {
    VStack {
        Text("Hello, World!")
            .padding()
            .frame(maxWidth: .infinity)
            .tappableBackground()
            .anyButton(.highlight, action: {
                // action
            })
            .padding()
        
        Text("Hello, World!")
            .callToActionButton()
            .anyButton(.press, action: {
                // action
            })
            .padding()
        
        Text("Hello, World!")
            .callToActionButton()
            .anyButton(action: {
                // action
            })
            .padding()
    }
}
