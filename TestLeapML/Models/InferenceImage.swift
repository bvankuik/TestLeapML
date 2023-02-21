//
//  InferenceImage.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 13/02/2023.
//

import Foundation

struct InferenceImage: Codable, Identifiable {
    let id: String
    let uri: String
    let createdAt: Date
    var url: URL? {
        URL(string: self.uri)
    }
}
