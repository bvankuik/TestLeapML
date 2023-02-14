//
//  GenerateImageService.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 08/02/2023.
//

import Foundation

// https://docs.leapml.dev/reference/inferencescontroller_create-1
struct GenerateImageService: Service {
    static func call(requestBody: RequestBody) async throws -> Inference {
        var request = makeRequest()
        
        guard let httpBody = try? JSONEncoder().encode(requestBody) else {
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

extension GenerateImageService {
    struct RequestBody: Codable {
        let prompt: String
        let negativePrompt: String
        let version: String?
        let steps: Int
        let width: Int
        let height: Int
        let numberOfImages: Int
        let promptStrength: Int
        var seed: Int {
            Int.random(in: 1..<(2<<15))
        }
        let webhookUrl: String?
    }
}

extension GenerateImageService.RequestBody {
    init(newImageViewModel: NewImage.ViewModel) {
        self.prompt = newImageViewModel.prompt
        self.negativePrompt = newImageViewModel.negativePrompt
        self.version = nil
        self.steps = newImageViewModel.steps
        self.width = 512
        self.height = 512
        self.numberOfImages = 1
        self.promptStrength = newImageViewModel.promptStrength
        self.webhookUrl = nil
    }
}
