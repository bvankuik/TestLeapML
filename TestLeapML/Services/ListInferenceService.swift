//
//  ListInferenceService.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 09/02/2023.
//

import Foundation
import os.log

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
