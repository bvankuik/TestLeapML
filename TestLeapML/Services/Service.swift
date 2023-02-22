//
//  Service.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 09/02/2023.
//

import Foundation

protocol Service {
    static func makeRequest() -> URLRequest
}

extension Service {
    static func makeRequest() -> URLRequest {
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
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "content-type": "application/json",
            "authorization": "Bearer \(apiKey)"
        ]
        return request
    }
}
