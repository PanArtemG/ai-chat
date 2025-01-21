//
//  AnyAppAlert.swift
//  AIChat
//
//  Created by Artem Panasenko on 21.01.2025.
//

import SwiftUI

/// An enumeration representing the type of alert to display.
///
/// This enum is used to determine the style of the alert presented in the UI.
///
/// - Cases:
///   - `alert`: Represents a standard alert with a title, optional message, and action buttons.
///   - `confirmationDialog`: Represents a confirmation dialog, typically used for presenting multiple choices.
///
/// ### Usage Example:
/// ```swift
/// let type: AlertType = .alert
/// ```
enum AlertType {
    case alert
    case confirmationDialog
}

/// A reusable alert model that defines the content and actions for an alert or confirmation dialog.
///
/// The `AnyAppAlert` struct provides a unified way to define the title, subtitle, and action buttons for both standard alerts and confirmation dialogs.
///
/// - Properties:
///   - `title`: The main title of the alert.
///   - `subtitle`: An optional subtitle providing additional context or information about the alert. Defaults to `nil`.
///   - `buttons`: A closure returning a SwiftUI view containing the action buttons for the alert. Defaults to a single "Ok" button.
///
/// - Initializers:
///   - `init(title:subtitle:buttons:)`
///     Initializes a new `AnyAppAlert` instance with the specified title, optional subtitle, and buttons.
///   - `init(error:)`
///     Creates an alert specifically for displaying error messages. The title is set to "Error," and the subtitle is populated with the error's localized description.
///
/// ### Usage Example:
/// ```swift
/// // Custom alert
/// let customAlert = AnyAppAlert(
///     title: "Custom Alert",
///     subtitle: "This is a custom alert with actions.",
///     buttons: {
///         AnyView(
///             VStack {
///                 Button("Confirm", action: {})
///                 Button("Cancel", action: {})
///             }
///         )
///     }
/// )
///
/// // Error alert
/// let errorAlert = AnyAppAlert(error: SomeError())
/// ```
///
/// ### Notes:
/// - The `buttons` closure allows for dynamic button customization.
/// - `AnyAppAlert` is designed to be thread-safe and compatible with Swift concurrency.
struct AnyAppAlert: Sendable {
    /// The main title of the alert.
    var title: String
    
    /// An optional subtitle providing additional context or information about the alert. Defaults to `nil`.
    var subtitle: String?
    
    /// A closure returning a SwiftUI view containing the action buttons for the alert.
    /// Defaults to a single "Ok" button.
    var buttons: @Sendable () -> AnyView
    
    /// Initializes a new `AnyAppAlert` instance with the specified title, optional subtitle, and buttons.
    ///
    /// - Parameters:
    ///   - title: The main title of the alert. (Required)
    ///   - subtitle: An optional subtitle providing additional context or information about the alert. (Optional, defaults to `nil`)
    ///   - buttons: A closure returning a SwiftUI view containing the action buttons for the alert. (Optional, defaults to a single "Ok" button)
    init(
        title: String,
        subtitle: String? = nil,
        buttons: (@Sendable () -> AnyView)? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        
        self.buttons = buttons ?? {
            AnyView(
                Button("Ok", action: { })
            )
        }
    }
    
    /// Initializes a new `AnyAppAlert` instance for displaying an error message.
    ///
    /// - Parameter error: An error instance whose `localizedDescription` will be used as the subtitle.
    init(error: Error) {
        self.init(
            title: "Error",
            subtitle: error.localizedDescription,
            buttons: nil
        )
    }
}
