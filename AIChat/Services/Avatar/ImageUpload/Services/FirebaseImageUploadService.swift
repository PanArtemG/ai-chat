//
//  FirebaseImageUploadService.swift
//  AIChat
//
//  Created by Artem Panasenko on 20.04.2025.
//

import FirebaseStorage
import SwiftUI

protocol ImageUploadServiceProtocol {
    func upload(_ image: UIImage, path: String) async throws -> URL
}

struct FirebaseImageUploadService: ImageUploadServiceProtocol {
    func upload(_ image: UIImage, path: String) async throws -> URL {
        guard let data = image.jpegData(compressionQuality: 0.8) else {
            throw URLError(.dataNotAllowed)
        }
        let url = try await save(data: data, by: path)
        print("Save by url: \(url.absoluteString)")
        
        return try await imageReference(by: path).downloadURL()
    }
    
    private func save(data: Data, by path: String) async throws -> URL {
        let reference = imageReference(by: path)
        let meta = StorageMetadata()
        meta.contentType = "image/jpeg"
        
        let returnedMeta = try await reference.putDataAsync(data, metadata: meta)
        guard let returnedPath = returnedMeta.path, let url = URL(string: returnedPath) else {
            throw URLError(.badServerResponse)
        }
        
        return url
    }
    
    private func imageReference(by path: String) -> StorageReference {
        let name = path + ".jpg"
        return Storage.storage().reference(withPath: name)
    }
}
