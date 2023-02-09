//
//  ServiceError.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 09/02/2023.
//

import Foundation

struct ServiceError: LocalizedError {
    let message: String

    init(_ message: String) {
        self.message = message
    }

    public var errorDescription: String? {
        return message
    }
}
