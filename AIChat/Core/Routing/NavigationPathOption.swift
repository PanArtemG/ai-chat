//
//  NavigationPathOption.swift
//  AIChat
//
//  Created by Artem Panasenko on 26.01.2025.
//

import SwiftUI

enum NavigationPathOption: Hashable {
    case chat(avatarId: String)
    case category(category: CharacterOption, imageUrlString: String)
}

extension View {
    func navigationDestinationForCoreModule(path: Binding<[NavigationPathOption]>) -> some View {
        self
            .navigationDestination(for: NavigationPathOption.self) { newValue in
                switch newValue {
                case .chat(avatarId: let avatarId):
                    ChatView(avatarId: avatarId)
                case .category(category: let category, imageUrlString: let imageUrlString):
                    CategoryListView(
                        path: path,
                        category: category,
                        imageUrlString: imageUrlString
                    )
                }
            }
    }
}
