//
//  ListInferenceService.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 09/02/2023.
//

import Foundation
import OSLog

struct ListInferenceService: Service {
    static func call() async throws -> [InferenceJob] {
        let request = makeRequest()
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ServiceError("URL response is not HTTPURLResponse")
        }
        os_log("Server statusCode: %d", log: .default, type: .debug, httpResponse.statusCode)
        
        if httpResponse.statusCode != 200 {
            os_log("Unexpected server statusCode: %d", log: .default, type: .error, httpResponse.statusCode)
            throw ServiceError("Server error \(httpResponse.statusCode)")
        }
        
        if let dataAsString = String(data: data, encoding: .utf8) {
            os_log("Data received:\n%@", log: .default, type: .debug, dataAsString)
        } else {
            os_log("Data received could not be read as UTF", log: .default, type: .fault)
        }
        let jobs = try Utils.makeDecoder().decode([InferenceJob].self, from: data)
        os_log("Received %d jobs", log: .default, type: .debug, jobs.count)
        return jobs
    }
}
