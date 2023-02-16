//
//  Utils.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 13/02/2023.
//

import Foundation

struct Utils {
    static func loadModel<T: Decodable>(_ type: T.Type, from jsonResource: String) -> T {
        let url = Bundle.main.url(forResource: jsonResource, withExtension: "json")
        let data = try! Data(contentsOf: url!)
        let model = try! Self.makeDecoder().decode(T.self, from: data)
        return model
    }
    
    static func makeDecoder() -> JSONDecoder {
        struct DateError: LocalizedError {
            let message: String
            
            init(_ message: String) {
                self.message = message
            }
            
            public var errorDescription: String? {
                return message
            }
        }
        
        let decoder = JSONDecoder()
        
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
            let container = try decoder.singleValueContainer()
            let dateStr = try container.decode(String.self)
            
            // Sometimes, our date has fractional seconds of 6 digits, and a full timezone
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSz"
            if let date = formatter.date(from: dateStr) {
                return date
            }
            // Other times, our date has 3 digits fractional seconds, and a Zulu timezone
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            if let date = formatter.date(from: dateStr) {
                return date
            }
            throw DateError("Could not parse date \(dateStr)")
        })
        return decoder
    }
}
