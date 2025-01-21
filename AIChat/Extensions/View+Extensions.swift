//
//  View+Extensions.swift
//  AIChat
//
//  Created by Artem Panasenko on 05.01.2025.
//

import SwiftUI

extension View {
    
    // MARK: - View's modifiers
    
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
    
    /// A view modifier that displays a custom alert or confirmation dialog based on the specified `AlertType`.
    ///
    /// This modifier presents either a SwiftUI alert or a confirmation dialog using the provided `AnyAppAlert` binding.
    ///
    /// - Parameters:
    ///   - type: The type of alert to display. Defaults to `.alert`. Options include:
    ///     - `.alert`: Displays a standard alert.
    ///     - `.confirmationDialog`: Displays a confirmation dialog.
    ///   - alert: A binding to an optional `AnyAppAlert` instance. If the binding's value is non-nil, the alert or dialog will be displayed.
    ///
    /// - Returns: A modified view capable of presenting the specified type of alert or dialog.
    ///
    /// ### Behavior:
    /// - **Alert**: Displays a standard alert with a title, optional subtitle, and action buttons.
    /// - **Confirmation Dialog**: Displays a confirmation dialog with a title, optional subtitle, and action buttons.
    ///
    /// ### Usage Example:
    /// ```swift
    /// struct ContentView: View {
    ///     @State private var customAlert: AnyAppAlert? = nil
    ///
    ///     var body: some View {
    ///         VStack {
    ///             Button("Show Alert") {
    ///                 customAlert = AnyAppAlert(
    ///                     title: "Alert Title",
    ///                     subtitle: "Optional subtitle text",
    ///                     buttons: {
    ///                         AnyView(
    ///                             Group {
    ///                                 Button("Yes", action: {})
    ///                                 Button("No", action: {})
    ///                             }
    ///                         )
    ///                     }
    ///                 )
    ///             }
    ///             .showCustomAlert(type: .alert, alert: $customAlert)
    ///
    ///             Button("Show Confirmation Dialog") {
    ///                 customAlert = AnyAppAlert(
    ///                     title: "Dialog Title",
    ///                     subtitle: "Optional subtitle text",
    ///                     buttons: {
    ///                         AnyView(
    ///                             Group {
    ///                                 Button("Yes", action: {})
    ///                                 Button("No", action: {})
    ///                             }
    ///                         )
    ///                     }
    ///                 )
    ///             }
    ///             .showCustomAlert(type: .confirmationDialog, alert: $customAlert)
    ///         }
    ///     }
    /// }
    /// ```
    ///
    /// ### Requirements:
    /// - `AlertType` should be an enumeration with `.alert` and `.confirmationDialog` cases.
    /// - `AnyAppAlert` must define `title`, optional `subtitle`, and a `buttons` method returning action buttons.
    ///
    /// ### Key Features:
    /// - Supports both standard alerts and confirmation dialogs.
    /// - Dynamically handles optional subtitles.
    /// - Provides reusable functionality for various alert types.
    @ViewBuilder
    func showCustomAlert(type: AlertType = .alert, alert: Binding<AnyAppAlert?>) -> some View {
        switch type {
        case .alert:
            self
                .alert(alert.wrappedValue?.title ?? "", isPresented: Binding(ifNotNil: alert)) {
                    alert.wrappedValue?.buttons()
                } message: {
                    if let subtitle = alert.wrappedValue?.subtitle {
                        Text(subtitle)
                    }
                }
        case .confirmationDialog:
            self
                .confirmationDialog(alert.wrappedValue?.title ?? "", isPresented: Binding(ifNotNil: alert)) {
                    alert.wrappedValue?.buttons()
                } message: {
                    if let subtitle = alert.wrappedValue?.subtitle {
                        Text(subtitle)
                    }
                }
        }
    }
}
