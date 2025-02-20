//
//  SettingsView.swift
//  AIChat
//
//  Created by Artem Panasenko on 05.01.2025.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(AuthManager.self) private var authManager
    @Environment(UserManager.self) private var userManager
    @Environment(AppState.self) private var appState
    
    @State private var isPremium: Bool = false
    @State private var isAnonymousUser: Bool = false
    @State private var showCreateAccountView: Bool = false
    @State private var showAlert: AnyAppAlert?
    
    private var accountStatusTextValue: String {
        if isPremium {
            return "Account status: PREMIUM"
        } else {
            return "Account status: FREE"
        }
    }
    
    private var spacingHS: CGFloat = 8
    private var lineOffset: CGFloat = 6
    
    var body: some View {
        NavigationStack {
            List {
                accountSection
                purchaseSection
                applicationSection
            }
            .navigationTitle("Settings")
            .sheet(isPresented: $showCreateAccountView, onDismiss: {
                setAnonymousAccountStatus()
            }, content: {
                CreateAccountView()
                    .presentationDetents([.medium])
            })
            .onAppear {
                setAnonymousAccountStatus()
            }
            .showCustomAlert(alert: $showAlert)
        }
    }
    
    // MARK: - View's components
    private var accountSection: some View {
        Section {
            if isAnonymousUser {
                Text("Save & back-up account")
                    .rowFormatting()
                    .anyButton(.highlight) {
                        onCreateAccountPress()
                    }
                    .removeListRowFormatting()
                
            } else {
                Text("Sign out")
                    .rowFormatting()
                    .anyButton(.highlight) {
                        onSignOutPressed()
                    }
                    .removeListRowFormatting()
            }
            
            Text("Delete account")
                .foregroundStyle(.red)
                .rowFormatting()
                .anyButton(.highlight) {
                    onDeleteAccountPressed()
                }
                .removeListRowFormatting()
        } header: {
            Text("Account")
        }
    }
    
    private var purchaseSection: some View {
        Section {
            HStack(spacing: spacingHS) {
                Text(accountStatusTextValue)
                Spacer(minLength: 0)
                if isPremium {
                    Text("manage")
                        .badgeButton()
                }
            }
            .rowFormatting()
            .anyButton(.highlight) {
                // TODO: BL
            }
            .disabled(!isPremium)
            .removeListRowFormatting()
        } header: {
            Text("Purchase")
        }
    }
    
    private var applicationSection: some View {
        Section {
            HStack(spacing: spacingHS) {
                Text("Version")
                Spacer(minLength: 0)
                Text(Utilities.appVersion ?? "")
                    .foregroundStyle(.secondary)
            }
            .rowFormatting()
            .removeListRowFormatting()
            
            HStack(spacing: spacingHS) {
                Text("Build Number")
                Spacer(minLength: 0)
                Text(Utilities.buildNumber ?? "")
                    .foregroundStyle(.secondary)
            }
            .rowFormatting()
            .removeListRowFormatting()
            
            Text("Contact us")
                .foregroundStyle(.blue)
                .rowFormatting()
                .anyButton(.highlight) {
                    // TODO: BL
                }
                .removeListRowFormatting()
        } header: {
            Text("Application")
        } footer: {
            VStack(alignment: .leading) {
                Text("Created by Artem Panasenko")
                Text("Lear more by www.artem.panasenko.com")
            }
            .baselineOffset(lineOffset)
        }
    }
    
    // MARK: - Busyness logik
    private func onSignOutPressed() {
        Task {
            do {
                try authManager.signOut()
                userManager.signOut()
                await dismissView()
            } catch {
                showAlert = AnyAppAlert(error: error)
            }
        }
    }
    
    private func dismissView() async {
        dismiss()
        try? await Task.sleep(for: .seconds(1))
        appState.updateViewState(showTabBarView: false)
    }
    
    private func onCreateAccountPress() {
        // do some logic to create account
        
        showCreateAccountView = true
    }
    
    private func setAnonymousAccountStatus() {
        isAnonymousUser = authManager.auth?.isAnonymous == true
    }
    
    private func onDeleteAccountPressed() {
        showAlert = AnyAppAlert(
            title: "Delete Account?",
            subtitle: "This action cannot be undone. Your data will be permanently deleted from server.",
            buttons: {
                AnyView(
                    Button("Delete", role: .destructive) {
                        onDeleteAccountConfirmed()
                    }
                )
            }
        )
    }
    
    private func onDeleteAccountConfirmed() {
        Task {
            do {
                // TODO: fix later
                try await authManager.deleteAccount()
                try await userManager.deleteCurrentUser()
                
                await dismissView()
            } catch {
                showAlert = AnyAppAlert(error: error)
            }
        }
    }
}

// MARK: - Extension
fileprivate extension View {
    func rowFormatting() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(Color.systemBackground)
    }
}

// MARK: - Preview
#Preview("No auth") {
    SettingsView()
        .environment(AuthManager(service: MockAuthService(user: nil)))
        .environment(UserManager(service: MockUserService(user: nil)))
        .environment(AppState())
}

#Preview("Anonymous") {
    SettingsView()
        .environment(AuthManager(service: MockAuthService(user: UserAuthInfo.mock(isAnonymous: true))))
        .environment(UserManager(service: MockUserService(user: .mock)))
        .environment(AppState())
}

#Preview("Not anonymous") {
    SettingsView()
        .environment(AuthManager(service: MockAuthService(user: UserAuthInfo.mock(isAnonymous: false))))
        .environment(UserManager(service: MockUserService(user: .mock)))
        .environment(AppState())
}
