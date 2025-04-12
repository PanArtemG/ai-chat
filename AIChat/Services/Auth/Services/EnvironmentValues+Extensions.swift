//
//  EnvironmentValues+Extensions.swift
//  AIChat
//
//  Created by Artem Panasenko on 28.01.2025.
//

import SwiftUI

/// Adds an authentication service to the environment for easy access in SwiftUI views.
///
/// This extension defines an `authService` property in `EnvironmentValues`, allowing any SwiftUI view
/// to access an instance of `AuthService`. By default, it is initialized as a `FirebaseAuthService`.
///
/// This makes it simple to inject and override the authentication service for testing or different
/// configurations, improving modularity and testability of your app.
///
/// Example usage in a SwiftUI view:
///
///     struct ContentView: View {
///         @Environment(\.authService) private var authService: AuthService
///
///         var body: some View {
///             VStack {
///                 Text("Welcome")
///                 Button("Login") {
///                     authService.login(withEmail: "user@example.com", password: "password123") { result in
///                         // Handle the login result (success or error).
///                     }
///                 }
///             }
///         }
///     }
///
extension EnvironmentValues {
//    @Entry var authService: AuthService = FirebaseAuthService()
}
