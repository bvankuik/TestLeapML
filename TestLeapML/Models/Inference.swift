//
//  Inference.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 13/02/2023.
//

import Foundation

// An inference only has image names, without their URIs.
struct Inference: Codable {
    let id, prompt, negativePrompt: String
    let createdAt: Date
    let seed, width, height, promptStrength: Int
    let numberOfImages, steps: Int
    let status: Status
    let images: [String]
    let modelID: String

    enum CodingKeys: String, CodingKey {
        case id, createdAt, prompt, negativePrompt, seed, width, height, promptStrength, numberOfImages, status,
             steps, images
        case modelID = "modelId"
    }
}
