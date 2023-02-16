//
//  InferenceImage.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 13/02/2023.
//

import Foundation

struct InferenceImage: Codable {
    let id: String
    let uri: String
    let createdAt: Date
}
