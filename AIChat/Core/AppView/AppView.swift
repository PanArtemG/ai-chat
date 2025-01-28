//
//  AppView.swift
//  AIChat
//
//  Created by Artem Panasenko on 05.01.2025.
//

import SwiftUI

struct AppView: View {
    @Environment(\.authService) private var authService
    @State var appState: AppState = AppState()
    
    var body: some View {
        AppViewBuilder(
            showTabBar: appState.showTabBar,
            tabbarView: {
                TabBarView()
            },
            onboardingView: {
                WelcomeView()
            }
        )
        .environment(appState)
        .task {
            await checkUserStatus()
        }
    }
    
    private func checkUserStatus() async {
        if let user = authService.getAuthenticatedUser() {
            //
            print("User already authenticated: \(user.uid)")
        } else {
            do {
                let result = try await authService.signInAnonymously()
                
                // log in to app
                print("signInAnonymously: SUCCESS: \(result.user.uid)")
            } catch {
                print("signInAnonymously: FAILED: \(error.localizedDescription)")
            }
        }
    }
}

// MARK: - Preview
#Preview("AppView - Tabbar") {
    AppView(appState: AppState(showTabBar: true))
}
#Preview("AppView - Onboarding") {
    AppView(appState: AppState(showTabBar: false))
}
