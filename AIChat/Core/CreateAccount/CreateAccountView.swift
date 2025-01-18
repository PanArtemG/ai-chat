//
//  CreateAccountView.swift
//  AIChat
//
//  Created by Artem Panasenko on 18.01.2025.
//

import SwiftUI

struct CreateAccountView: View {
    var title: String = "Create Account?"
    var subtitle: String = "Don't lose your data! Connect to ab SSO provider to save your account."

    var body: some View {
        VStack(spacing: 24) {
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
                style: .black, cornerRadius: 10
            )
            .frame(height: 55)
            .anyButton(.press) {
                
            }
            
            Spacer()
        }
        .padding()
        .padding(.top, 40)
    }
}

// MARK: - Preview
#Preview {
    CreateAccountView()
}
