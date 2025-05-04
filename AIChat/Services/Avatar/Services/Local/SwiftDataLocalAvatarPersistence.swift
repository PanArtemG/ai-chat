//
//  SwiftDataLocalAvatarPersistence.swift
//  AIChat
//
//  Created by Artem Panasenko on 04.05.2025.
//

import Foundation
import SwiftData

@MainActor
struct SwiftDataLocalAvatarPersistence: LocalAvatarPersistenceProtocol {
    private let container: ModelContainer
    private var mainContext: ModelContext { container.mainContext }
    
    init() {
        guard let container = try? ModelContainer(for: AvatarEntity.self) else {
            fatalError("Failed to initialize ModelContainer")
        }
        self.container = container
    }
    
    func addRecentAvatar(_ avatar: Avatar) throws {
        let entity = AvatarEntity(from: avatar)
        mainContext.insert(entity)
        try mainContext.save()
    }
    
    func getRecentAvatars() throws -> [Avatar] {
        let sortDescriptor = SortDescriptor<AvatarEntity>( \.addedAt, order: .reverse)
        let fetchDescriptor = FetchDescriptor<AvatarEntity>(sortBy: [sortDescriptor])
        let entities = try mainContext.fetch(fetchDescriptor)
        return entities.map { $0.toModel() }
    }
}
