//
//  OnboardingCompletedView.swift
//  AIChat
//
//  Created by Artem Panasenko on 05.01.2025.
//

import SwiftUI

struct OnboardingCompletedView: View {
    @Environment(AppState.self) private var root
    @Environment(UserManager.self) private var userManager
    
    @State private var isCompetingProfileSetup: Bool = false
    var selectedColor: Color
    
    private let padding: CGFloat = 24
    
    var body: some View {
        VStack(alignment: .leading, spacing: padding) {
            Text("Setup completed!")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundStyle(selectedColor)
            
            Text("We've set up for profile and now you're ready to start chatting.")
                .font(.title)
                .fontWeight(.medium)
                .foregroundStyle(.secondary)
        }
        .frame(maxHeight: .infinity)
        .safeAreaInset(edge: .bottom, content: {
            AsyncCallToActionButton(
                title: "Finish",
                isLoading: isCompetingProfileSetup,
                action: onFinishButtonPressed
            )
        })
        .padding(padding)
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private func onFinishButtonPressed() {
        isCompetingProfileSetup = true
        Task {
            let hex = selectedColor.toHex() ?? Constants.accentColorHex
            try await userManager.markOnboardingCompleteForCurrentUser(profileColorHex: hex)
            
            // dismiss screen
            isCompetingProfileSetup = false
            root.updateViewState(showTabBarView: true)
        }
    }
}

// MARK: - Preview
#Preview {
    OnboardingCompletedView(selectedColor: .orange)
        .environment(AppState())
        .environment(UserManager(services: MockUserServices(user: nil)))
}
