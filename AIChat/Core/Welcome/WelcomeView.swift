//
//  WelcomeView.swift
//  AIChat
//
//  Created by Artem Panasenko on 05.01.2025.
//

import SwiftUI

struct WelcomeView: View {
    
    @State var imageUrl = Constants.randomImageUrl
    
    private let termsURLString = Constants.termsOfServiceUrl
    private let privacyPolicyURLString = Constants.privacyPolicyUrl
    private let headerPadding: CGFloat = 24
    private let spacing: CGFloat = 8
    private let tapGesturePadding: CGFloat = 8
    
    var body: some View {
        NavigationStack {
            VStack(spacing: spacing) {
                ImageLoaderView(urlString: imageUrl)
                    .ignoresSafeArea()
                
                titleSection
                    .padding(.top, headerPadding)
                
                ctaSection
                    .padding()
                
                termsSection
            }
        }
    }
    
    private var titleSection: some View {
        VStack {
            Text("AI Chat")
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            Text("Intelligent conversations made simple")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
    
    private var ctaSection: some View {
        VStack(spacing: spacing) {
            NavigationLink {
                OnboardingCompletedView()
            } label: {
                Text("Get Started")
                    .callToActionButton()
            }
            
            Text("Already have an account? Sign in.")
                .underline()
                .font(.body)
                .padding(tapGesturePadding)
                .foregroundStyle(.black)
                .onTapGesture {
                    // TODO: Future implementation
                }
        }
    }
    
    private var termsSection: some View {
        HStack(spacing: spacing) {
            if let url = URL(string: termsURLString) {
                Link(destination: url) {
                    Text("Terms of Service")
                }
            }
            
            Circle()
                .fill(.accent)
                .frame(width: 4)
            
            if let url = URL(string: privacyPolicyURLString) {
                Link(destination: url) {
                    Text("Privacy Policy")
                }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    WelcomeView()
}
