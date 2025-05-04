//
//  AIManager.swift
//  AIChat
//
//  Created by Artem Panasenko on 13.04.2025.
//

import SwiftUI

@MainActor
@Observable
class AIManager {
    
    private let service: AIServiceProtocol
    
    private(set) var auth: UserAuthInfo?
    
    private var listener: (any NSObjectProtocol)?
    
    init(service: AIServiceProtocol) {
        self.service = service
    }
    
    func generateImage(input: String) async throws -> UIImage {
        try await service.generateImage(input: input)
    }
    
}
