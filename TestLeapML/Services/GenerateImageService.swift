//
//  GenerateImageService.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 08/02/2023.
//

import Foundation
import OSLog

// https://docs.leapml.dev/reference/inferencescontroller_create-1
struct GenerateImageService: Service {
    static func call(requestBody: RequestBody) async throws -> Inference {
        var request = makeRequest()
        
        guard let httpBody = try? JSONEncoder().encode(requestBody) else {
            throw ServiceError("Error encoding body")
        }
        
        if let bodyString = String(data: httpBody, encoding: .utf8) {
            os_log("Submitting request to generate image with body:\n%@", log: .default, type: .debug, bodyString)
        }
        request.httpMethod = "POST"
        request.httpBody = httpBody

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ServiceError("URL response is not HTTPURLResponse")
        }
        os_log("Server statusCode: %d", log: .default, type: .debug, httpResponse.statusCode)

        if !([200, 201].contains(httpResponse.statusCode)) {
            os_log("Unexpected server statusCode: %d", log: .default, type: .error, httpResponse.statusCode)
            if let responseString = String(data: data, encoding: .utf8) {
                os_log("Response:\n%@", log: .default, type: .debug, responseString)
            }
            throw ServiceError("Server error, status code: \(httpResponse.statusCode)")
        }
        
        return try Utils.makeDecoder().decode(Inference.self, from: data)
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
        self.width = newImageViewModel.resolution.width
        self.height = newImageViewModel.resolution.height
        self.numberOfImages = newImageViewModel.numberOfImages
        self.promptStrength = newImageViewModel.promptStrength
        self.webhookUrl = nil
    }
}
