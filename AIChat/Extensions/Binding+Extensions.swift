//
//  Binding+Extensions.swift
//  AIChat
//
//  Created by Artem Panasenko on 21.01.2025.
//

import SwiftUI

extension Binding where Value == Bool {
    
    /// An initializer for `Binding<Bool>` that reflects the presence or absence of a non-optional value in a `Binding<T?>`.
    ///
    /// This initializer creates a `Binding<Bool>` that is `true` when the wrapped value of the provided optional binding is non-nil,
    /// and `false` when the wrapped value is `nil`. Setting the `Bool` value to `false` clears the optional binding's value.
    ///
    /// - Parameters:
    ///   - value: A binding to an optional value of type `T?`.
    ///
    /// ### Behavior:
    /// - **Getter**: Returns `true` if `value.wrappedValue` is non-nil; otherwise, returns `false`.
    /// - **Setter**: Sets `value.wrappedValue` to `nil` when the `Bool` is set to `false`.
    ///
    /// ### Usage Example:
    /// ```swift
    /// struct ContentView: View {
    ///     @State private var optionalValue: String? = "Hello"
    ///
    ///     var body: some View {
    ///         Toggle("Toggle Optional", isOn: Binding(ifNotNil: $optionalValue))
    ///             .onChange(of: optionalValue) { newValue in
    ///                 print("Optional value is now: \(newValue ?? "nil")")
    ///             }
    ///     }
    /// }
    /// ```
    ///
    /// ### Requirements:
    /// - The generic type `T` must conform to `Sendable`.
    /// - This extension is useful for managing bindings where the presence of a value (or lack thereof) should be reflected as a `Bool`.
    init<T: Sendable>(ifNotNil value: Binding<T?>) {
        self.init {
            value.wrappedValue != nil
        } set: { newValue in
            if !newValue {
                value.wrappedValue = nil
            }
        }
    }
}
