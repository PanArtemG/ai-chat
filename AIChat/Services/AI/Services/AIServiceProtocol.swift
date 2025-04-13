//
//  AIServiceProtocol.swift
//  AIChat
//
//  Created by Artem Panasenko on 13.04.2025.
//

import SwiftUI

protocol AIServiceProtocol: Sendable {
    func generateImage(input: String) async throws -> UIImage
}
