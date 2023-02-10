//
//  GenerateImageService.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 08/02/2023.
//

import Foundation

struct Inference: Codable {
    let id, createdAt, prompt, negativePrompt: String
    let seed, width, height, promptStrength: Int
    let numberOfImages, steps: Int
    let status: String // queued
    let images: [String]
    let modelID: String

    enum CodingKeys: String, CodingKey {
        case id, createdAt, prompt, negativePrompt, seed, width, height, promptStrength, numberOfImages, status, steps, images
        case modelID = "modelId"
    }
}

struct GenerateImageBody: Codable {
    let prompt: String
    let negativePrompt: String
    let version: String?
    let steps: Int
    let width: Int
    let height: Int
    let numberOfImages: Int
    let promptStrength: Int
    let seed: Int
    let webhookUrl: String?
}

struct GenerateImageService: Service {
    static func call() async throws -> Inference {
        var request = makeRequest()
        
        let generateImageBody = GenerateImageBody(
            prompt: "@cat with a hat",
            negativePrompt: "asymmetric, watermarks",
            version: nil,
            steps: 50,
            width: 512,
            height: 512,
            numberOfImages: 2,
            promptStrength: 7,
            seed: Int.random(in: 1..<(2<<15)),
            webhookUrl: nil
        )
        guard let httpBody = try? JSONEncoder().encode(generateImageBody) else {
            throw ServiceError("Error encoding body")
        }
        
        print(String(data: httpBody, encoding: .utf8)!)
        request.httpMethod = "POST"
        request.httpBody = httpBody

        let (data, response) = try await URLSession.shared.data(for: request)
        if let httpResponse = response as? HTTPURLResponse,
           !([200, 201].contains(httpResponse.statusCode)) {
            
            print(String(data: data, encoding: .utf8)!)
            print("Server statusCode = \(httpResponse.statusCode)")
            throw ServiceError("Server error")
        }
        
        return try JSONDecoder().decode(Inference.self, from: data)
    }
}
