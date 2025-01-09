//
//  View+Extensions.swift
//  AIChat
//
//  Created by Artem Panasenko on 05.01.2025.
//

import SwiftUI

extension View {
    
    // MARK: - View modifiers
    
    /// View modifier used for call to action button
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
    
    // TODO: Remove after complete
    /*
     /// View modifier used for for a larger area of ​​view
     /// - Returns: `View`
     func tappableBackground() -> some View {
     background(.black.opacity(0.001))
     }
     */
    
    // MARK: - List modifiers
    
    /// Setup list row's `inset` and `background`
    /// Inset as `EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)`
    /// Background as `Color.clear`
    /// - Returns: `View`
    func removeListFormatting() -> some View {
        self
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowBackground(Color.clear)
    }
}
