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
    
    /// Conditionally applies a transformation to a SwiftUI view based on a boolean condition.
    ///
    /// This method enables the dynamic application of a modifier or transformation to the view
    /// only if the specified condition evaluates to `true`. If the condition is `false`, the original view is returned unchanged.
    ///
    /// - Parameters:
    ///   - condition: A boolean value that determines whether the transformation should be applied.
    ///   - transform: A closure that defines the transformation or modifier to apply to the view
    ///                when the condition is satisfied.
    ///
    /// - Returns: A view that is either the original or transformed, based on the condition.
    ///
    /// ### Usage Example:
    /// ```swift
    /// Text("Hello, World!")
    ///     .ifSatisfiedCondition(true) { view in
    ///         view.foregroundColor(.red)
    ///     }
    ///
    /// Text("This is not modified")
    ///     .ifSatisfiedCondition(false) { view in
    ///         view.foregroundColor(.blue)
    ///     }
    /// ```
    ///
    /// ### Notes:
    /// - This method is particularly useful for conditionally applying multiple modifiers in a clean and readable way.
    @ViewBuilder
    func ifSatisfiedCondition(_ condition: Bool, transform: (Self) -> some View) -> some View {
        if condition {
            transform(self) // Apply the transformation if the condition is true
        } else {
            self // Return the original view if the condition is false
        }
    }
    
    /// Displays a modal view over the current view when a binding condition is `true`.
    ///
    /// This method enables a modal presentation using an `overlay` mechanism. The modal's visibility
    /// is controlled by a binding, and its content is defined by the provided closure.
    ///
    /// - Parameters:
    ///   - showModal: A `Binding<Bool>` that determines whether the modal should be shown.
    ///                When the binding's value is `true`, the modal appears.
    ///   - content: A closure that defines the content of the modal. The closure returns a view to be displayed as the modal.
    ///
    /// - Returns: A view with a modal overlay that appears when `showModal` is `true`.
    ///
    /// ### Usage Example:
    /// ```swift
    /// struct ContentView: View {
    ///     @State private var isModalVisible = false
    ///
    ///     var body: some View {
    ///         VStack {
    ///             Button("Show Modal") {
    ///                 isModalVisible = true
    ///             }
    ///         }
    ///         .showModal($isModalVisible) {
    ///             VStack {
    ///                 Text("This is a modal")
    ///                 Button("Close") {
    ///                     isModalVisible = false
    ///                 }
    ///             }
    ///             .padding()
    ///             .background(Color.white)
    ///             .cornerRadius(8)
    ///             .shadow(radius: 10)
    ///         }
    ///     }
    /// }
    /// ```
    ///
    /// ### Notes:
    /// - The `content` closure defines the view displayed as the modal.
    /// - The modal overlay is added using the `overlay` modifier, which positions it above the main view.
    ///
    /// ### See Also:
    /// - `ModalSupportView` for handling modal behavior internally.
    func showModal(_ showModal: Binding<Bool>, @ViewBuilder content: () -> some View) -> some View {
        self
            .overlay(
                ModalSupportView(showModal: showModal) {
                    content()
                }
            )
    }
}
