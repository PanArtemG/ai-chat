//
//  CreateAvatarView.swift
//  AIChat
//
//  Created by Artem Panasenko on 20.01.2025.
//

import SwiftUI

struct CreateAvatarView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var avatarName: String = ""
    @State private var characterOption: CharacterOption = .default
    @State private var characterAction: CharacterAction = .default
    @State private var characterLocation: CharacterLocation = .default
    @State private var generatedAvatar: UIImage?
    @State private var isGenerating: Bool = false
    @State private var isSaving: Bool = false
    
    private var isGenerateButtonDisabled: Bool {
        isSaving || isGenerating || avatarName.isEmpty
    }
    
    private var isSaveButtonDisabled: Bool {
        isSaving || generatedAvatar == nil || avatarName.isEmpty
    }
    private let paddingSaveButton: CGFloat = 48
    
    var body: some View {
        NavigationStack {
            List {
                nameSection
                attributesSection
                avatarSection
                saveSection
                
            }
            .navigationTitle("Create Avatar")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    backButton
                }
            }
        }
    }
    
    // MARK: - View's components
    private var nameSection: some View {
        Section {
            TextField("Player name", text: $avatarName)
        } header: {
            Text("Name your avatar*")
        }
    }
    
    private var attributesSection: some View {
        Section {
            Picker(selection: $characterOption) {
                ForEach(CharacterOption.allCases, id: \.self) { option in
                    let characterOptionTextValue = option.rawValue.capitalized
                    Text(characterOptionTextValue)
                        .tag(option)
                }
            } label: {
                Text("is a...")
            }
            
            Picker(selection: $characterAction) {
                ForEach(CharacterAction.allCases, id: \.self) { option in
                    let characterActionTextValue = option.rawValue.capitalized
                    Text(characterActionTextValue)
                        .tag(option)
                }
            } label: {
                Text("that is...")
            }
            
            Picker(selection: $characterLocation) {
                ForEach(CharacterLocation.allCases, id: \.self) { option in
                    let characterLocationTextValue = option.rawValue.capitalized
                    Text(characterLocationTextValue)
                        .tag(option)
                }
            } label: {
                Text("in the...")
            }
        } header: {
            Text("Attributes")
        }
    }
    
    private var avatarSection: some View {
        Section {
            HStack(alignment: .top) {
                ZStack {
                    Text("Generate avatar")
                        .underline()
                        .foregroundStyle(.accent)
                        .anyButton(.plain) {
                            onGenerateAvatarPressed()
                        }
                        .opacity(isGenerating ? 0 : 1)
                    
                    ProgressView()
                        .tint(Color(uiColor: .accent))
                        .opacity(isGenerating ? 1 : 0)
                    
                }
                .disabled(isGenerateButtonDisabled)
                
                Circle()
                    .fill(Color.secondary.opacity(0.3))
                    .overlay {
                        ZStack {
                            if let generatedAvatar {
                                Image(uiImage: generatedAvatar)
                                    .resizable()
                                    .scaledToFill()
                                    .foregroundColor(.accent)
                            }
                        }
                    }
            }
            .frame(maxWidth: .infinity)
            .removeListRowFormatting()
        }
        .removeListRowFormatting()
        
    }
    
    private var saveSection: some View {
        Section {
            AsyncCallToActionButton(
                title: "Save",
                isLoading: isSaving,
                action: onSavePressed
            )
            .disabled(isGenerateButtonDisabled)
        }
        .removeListRowFormatting()
        .padding(.top, paddingSaveButton)
        .opacity(isSaveButtonDisabled ? 0.5 : 1)
        .disabled(isSaveButtonDisabled)
    }
    
    private var backButton: some View {
        Image(systemName: "xmark")
            .font(.title2)
            .fontWeight(.semibold)
            .foregroundStyle(.accent)
            .anyButton(.plain) {
                onBackButtonPress()
            }
    }
    
    // MARK: - Business logic
    private func onGenerateAvatarPressed() {
        isGenerating = true
        
        Task {
            try? await Task.sleep(for: .seconds(3))
            generatedAvatar = UIImage(systemName: "person.circle.fill")
            isGenerating = false
        }
    }
    
    private func onSavePressed() {
        isSaving = true
        
        Task {
            try? await Task.sleep(for: .seconds(3))
            isSaving = false
            dismiss()
        }
    }
    
    private func onBackButtonPress() {
        dismiss()
    }
}

// MARK: - Preview
#Preview {
    CreateAvatarView()
}
