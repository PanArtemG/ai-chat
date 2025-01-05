//
//  ProfileView.swift
//  AIChat
//
//  Created by Artem Panasenko on 05.01.2025.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var showSettingsView = false
    
    var body: some View {
        NavigationStack {
            Text("Profile")
                .navigationTitle("Profile")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            showSettingsView = true
                        } label: {
                            Image(systemName: "gear")
                                .font(.headline)
                        }
                    }
                }
        }
        .sheet(isPresented: $showSettingsView) {
            Text("SettingsView")
        }
    }
}

// MARK: - Preview
#Preview {
    ProfileView()
}
