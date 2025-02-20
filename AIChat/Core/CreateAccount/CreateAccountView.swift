//
//  CreateAccountView.swift
//  AIChat
//
//  Created by Artem Panasenko on 18.01.2025.
//

import SwiftUI

struct CreateAccountView: View {
    @Environment(AuthManager.self) private var authManager
    @Environment(UserManager.self) private var userManager
    @Environment(\.dismiss) private var dismiss
    
    var title: String = "Create Account?"
    var subtitle: String = "Don't lose your data! Connect to ab SSO provider to save your account."
    var onDidSigIn: ((_ isNewUser: Bool) -> Void)?
    
    private let spacing: CGFloat = 24
    private let cornerRadius: CGFloat = 10
    private let height: CGFloat = 55
    private let paddingTop: CGFloat = 40
    
    var body: some View {
        VStack(spacing: spacing) {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                
                Text(subtitle)
                    .font(.body)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            SignInWithAppleButtonView(
                type: .signIn,
                style: .black,
                cornerRadius: cornerRadius
            )
            .frame(height: height)
            .anyButton(.press) {
                onSignInWithApplePressed()
            }
            
            Spacer()
        }
        .padding()
        .padding(.top, paddingTop)
    }
    
    // MARK: - Busyness logik
    private func onSignInWithApplePressed() {
        Task {
            do {
                let result = try await authManager.signInApple()
                print("Did sign in with Apple: \(result.user.uid)")
                
                try await userManager.logIn(auth: result.user, isNewUser: result.isNewUser)
                print("Did log in")
                      
                onDidSigIn?(result.isNewUser)
                dismiss()
            } catch {
                print("Error signing in with Apple: \(error)")
            }
        }
    }
}

// MARK: - Preview
#Preview {
    CreateAccountView()
}
