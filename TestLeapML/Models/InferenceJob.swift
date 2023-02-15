//
//  InferenceJob.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 13/02/2023.
//

import Foundation

// An inference job has images that include an URI
struct InferenceJob: Codable, Identifiable {
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
