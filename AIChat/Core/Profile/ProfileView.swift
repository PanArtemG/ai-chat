//
//  ProfileView.swift
//  AIChat
//
//  Created by Artem Panasenko on 05.01.2025.
//

import SwiftUI

struct ProfileView: View {
    @Environment(UserManager.self) private var userManager
    
    @State private var showSettingsView = false
    @State private var showCreateAvatarView = false
    @State private var currentUser: UserModel?
    @State private var myAvatars: [Avatar] = []
    @State private var isLoading: Bool = true
    @State private var path: [NavigationPathOption] = []
    
    private let avatarSize: CGFloat = 100
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                myInfoSection
                myAvatarsSection
            }
            .navigationTitle("Profile")
            .navigationDestinationForCoreModule(path: $path)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    settingsButton
                }
            }
        }
        .sheet(isPresented: $showSettingsView) {
            SettingsView()
        }
        .fullScreenCover(isPresented: $showCreateAvatarView) {
            CreateAvatarView()
        }
        .task {
            await loadData()
        }
    }
    
    private var myInfoSection: some View {
        Section {
            ZStack {
                Image(systemName: "person.circle.fill")
                    .font(.system(size: avatarSize))
                    .foregroundColor(currentUser?.profileColor ?? .accent)
            }
            .frame(maxWidth: .infinity)
            .removeListRowFormatting()
        }
    }
    
    private var myAvatarsSection: some View {
        Section {
            if myAvatars.isEmpty {
                Group {
                    if isLoading {
                        ProgressView()
                    } else {
                        VStack {
                            Text("You haven't created any Avatar")
                            Text("Press + and create new Avatar")
                            createAvatarButton
                                .padding()
                        }
                    }
                }
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity)
                .removeListRowFormatting()
            } else {
                ForEach(myAvatars, id: \.self) { avatar in
                    CustomListCellView(
                        imageUrl: avatar.profileImageUrl,
                        title: avatar.name,
                        subtitle: nil
                    )
                    .anyButton(.highlight) {
                        onAvatarPressed(avatar: avatar)
                    }
                    .removeListRowFormatting()
                }
                .onDelete { indexSet in
                    onDeleteAvatar(indexSet: indexSet)
                }
            }
        } header: {
            HStack(spacing: 0) {
                if !myAvatars.isEmpty {
                    Text("My avatars")
                    Spacer()
                    
                    createAvatarButton
                }
            }
        }
    }
    
    // MARK: - View's components
    private var settingsButton: some View {
        Image(systemName: "gear")
            .font(.headline)
            .foregroundStyle(.accent)
            .anyButton {
                onSettingsButtonPressed()
            }
    }
    
    private var createAvatarButton: some View {
        Image(systemName: "plus.circle.fill")
            .font(.title)
            .foregroundStyle(.accent)
            .anyButton {
                onNewAvatarButtonPressed()
            }
    }
    
    private func onNewAvatarButtonPressed() {
        showCreateAvatarView = true
    }
    
    // MARK: - Busyness logik
    private func onAvatarPressed(avatar: Avatar) {
        let pathOption: NavigationPathOption = .chat(avatarId: avatar.id)
        path.append(pathOption)
    }
    
    private func onDeleteAvatar(indexSet: IndexSet) {
        guard let index = indexSet.first else {
            return
        }
        myAvatars.remove(at: index)
    }
    
    private func onSettingsButtonPressed() {
        showSettingsView = true
    }
    
    private func loadData() async {
        self.currentUser = userManager.currentUser
        isLoading = false
        myAvatars = Avatar.mocks
    }
}

// MARK: - Preview
#Preview {
    ProfileView()
        .environment(AppState())
        .environment(UserManager(service: MockUserService(user: .mock)))
}
