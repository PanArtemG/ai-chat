//
//  OnboardingIntroView.swift
//  AIChat
//
//  Created by Artem Panasenko on 06.01.2025.
//

import SwiftUI

struct OnboardingIntroView: View {
    private var sectionPadding: CGFloat = 24
    private var descriptionTextOffSet: CGFloat = 6
    
    var body: some View {
        VStack {
            // Description section
            Group {
                Text("Make your own ")
                +
                Text("avatars ")
                    .foregroundStyle(.accent)
                    .fontWeight(.semibold)
                +
                Text("and chat with them!")
                +
                Text("\n \nHave ")
                +
                Text("real conversation ")
                    .foregroundStyle(.accent)
                    .fontWeight(.semibold)
                +
                Text("with AI generated response.")
            }
            .baselineOffset(descriptionTextOffSet)
            .frame(maxHeight: .infinity)
            .padding(sectionPadding)
            
            // Action section
            NavigationLink {
                OnboardingColorView()
            } label: {
                Text("Continue")
                    .callToActionButton()
            }
        }
        .font(.title3)
        .padding(sectionPadding)
        .toolbar(.hidden, for: .navigationBar)
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        OnboardingIntroView()
    }
}
