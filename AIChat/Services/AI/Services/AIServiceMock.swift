//
//  AIServiceMock.swift
//  AIChat
//
//  Created by Artem Panasenko on 13.04.2025.
//

import SwiftUI

struct AIServiceMock: AIServiceProtocol {
    func generateImage(input: String) async throws -> UIImage {
        try await Task.sleep(for: .seconds(1.5))
        return UIImage(systemName: "star.fill")!
    }
}
