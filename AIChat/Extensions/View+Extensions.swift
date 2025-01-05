//
//  View+Extensions.swift
//  AIChat
//
//  Created by Artem Panasenko on 05.01.2025.
//

import SwiftUI

extension View {
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
}
