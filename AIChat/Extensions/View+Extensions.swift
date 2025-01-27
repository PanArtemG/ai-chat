//
//  View+Extensions.swift
//  AIChat
//
//  Created by Artem Panasenko on 05.01.2025.
//

import SwiftUI

extension View {
    
    // MARK: - View modifiers
    
    /// A view modifier that styles a view to appear as an action button
    /// - Parameters:
    ///   - cornerRadius: as `CGFloat`. Default value equal `16`
    ///   - height: as `CGFloat`. Default value equal `56`
    /// - Returns: `View`
    func callToActionButton(cornerRadius: CGFloat = 16, height: CGFloat = 56) -> some View {
        self
            .font(.headline)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: height)
            .background(.accent)
            .cornerRadius(cornerRadius)
    }
    
    /// A view modifier that styles a view to appear as a badge button.
    ///
    /// This modifier applies the following styles:
    /// - Font: `caption`
    /// - Text case: `uppercase`
    /// - Text weight: `bold`
    /// - Padding: `6`
    /// - Foreground color: `white`
    /// - Background color: `blue`
    /// - Corner radius: `6`
    ///
    /// - Returns: A styled view that appears as a badge button.
    func badgeButton() -> some View {
        self
            .font(.caption)
            .textCase(.uppercase)
            .bold()
            .padding(.horizontal, 8)
            .padding(.vertical, 6)
            .foregroundStyle(.white)
            .background(.blue)
            .cornerRadius(6)
    }
    
    /// Added background for  readability
    /// - Returns: `View`
    func addingGradientBackgroundForText() -> some View {
        background(
            LinearGradient(
                colors: [
                    .black.opacity(0),
                    .black.opacity(0.3),
                    .black.opacity(0.5)],
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
    
     /// View modifier used for for a larger area of ​​view
     /// - Returns: `View`
    func tappableBackground() -> some View {
        background(.black.opacity(0.001))
    }
    
    // MARK: - List modifiers
    
    /// Setup list row's `inset` and `background`
    /// Inset as `EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)`
    /// Background as `Color.clear`
    /// - Returns: `View`
    func removeListRowFormatting() -> some View {
        self
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowBackground(Color.clear)
    }
}
