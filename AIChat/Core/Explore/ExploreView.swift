//
//  ExploreView.swift
//  AIChat
//
//  Created by Artem Panasenko on 05.01.2025.
//

import SwiftUI

struct ExploreView: View {
    
    let avatar = AvatarModel.mock
    
    var body: some View {
        NavigationStack {
            HeroCellView(
                title: avatar.name,
                subtitle: avatar.characteDescription,
                imageUrl: avatar.profileImageUrl
            )
            .frame(height: 300)
        }
    }
}

// MARK: - Preview
#Preview {
    ExploreView()
}
