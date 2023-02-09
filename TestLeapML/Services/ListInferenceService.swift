//
//  ListInferenceService.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 09/02/2023.
//

import Foundation
import os.log

// MARK: - Inference
struct InferenceJob: Codable {
    let id, status, prompt, negativePrompt: String
    let seed, width, height, numberOfImages: Int
    let steps: Int
    let createdAt: String
    let promptStrength: Int
    let images: [InferenceImage]
    let modelID: String

    enum CodingKeys: String, CodingKey {
        case id, status, prompt, negativePrompt, seed, width, height, numberOfImages, steps, createdAt, promptStrength, images
        case modelID = "modelId"
    }
}

// MARK: - Image
struct InferenceImage: Codable {
    let id: String
    let uri: String
    let createdAt: String
}

struct ListInferenceService: Service {
    static func call() async throws -> [InferenceJob] {
        let request = makeRequest()
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
            print("Server status \(httpResponse.statusCode)")
            throw ServiceError("Server error \(httpResponse.statusCode)")
        }
        
        return try JSONDecoder().decode([InferenceJob].self, from: data)
    }
}
