//
//  Inference.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 13/02/2023.
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