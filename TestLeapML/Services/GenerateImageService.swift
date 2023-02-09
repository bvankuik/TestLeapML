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
    let numberOfImages, state, steps: Int
    let images, modelID: [String]

    enum CodingKeys: String, CodingKey {
        case id, createdAt, prompt, negativePrompt, seed, width, height, promptStrength, numberOfImages, state, steps, images
        case modelID
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

struct GenerateImageService {
    static func call() async throws -> [Inference] {
        let modelID = "8b1b897c-d66d-45a6-b8d7-8e32421d02cf"
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.leapml.dev"
        components.path = "/api/v1/images/models/\(modelID)/inferences"
        
        guard let url = components.url else {
            fatalError("Can't build URL for some reason")
        }
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
            fatalError("API key not found")
        }
        
        let generateImageBody = GenerateImageBody(
            prompt: "@cat with a hat",
            negativePrompt: "asymmetric, watermarks",
            version: nil,
            steps: 50,
            width: 512,
            height: 512,
            numberOfImages: 1,
            promptStrength: 7,
            seed: Int.random(in: 1..<(2<<15)),
            webhookUrl: nil
        )
        guard let httpBody = try? JSONEncoder().encode(generateImageBody) else {
            throw ServiceError("Error encoding body")
        }
        
        print(String(data: httpBody, encoding: .utf8)!)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = httpBody
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "content-type": "application/json",
            "authorization": "Bearer \(apiKey)",
        ]
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw ServiceError("Server error")
        }
        
        return try JSONDecoder().decode([Inference].self, from: data)
    }
}
